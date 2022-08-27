from datetime import datetime
from django.db import models
from django.contrib.auth.models import AbstractUser
from forage import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
from django.utils import timezone
from django.db.models import Q


class User(AbstractUser):
    date_of_birth = models.DateTimeField(null=True, blank=True)
    affiliation = models.CharField(max_length=256, null=True, blank=True)
    designation = models.CharField(max_length=256, null=True, blank=True)


@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)


class Keyword(models.Model):
    name = models.CharField(max_length=128, unique=True)


    def save(self, *args, **kwargs):
        self.name = self.name.lower()
        super(Keyword, self).save(*args, **kwargs)
 

    def __str__(self):
        return f"{self.id}-{self.name}"


class Domain(models.Model):
    name = models.CharField(max_length=128, unique=True)


    def save(self, *args, **kwargs):
        self.name = self.name.lower()
        super(Domain, self).save(*args, **kwargs)
 

    def __str__(self):
        return f"{self.id}-{self.name}"


class Project(models.Model):
    name = models.CharField(max_length=256)  # TODO: Add to ERD
    # FIXME: What is the purpose of the url
    url = models.CharField(max_length=256, null=True, blank=True)  
    description = models.TextField(default="", blank=True)
    # FIXME: Instead of is_default here, link default project in User model
    is_default = models.BooleanField(default=False, blank=True)  

    # TODO: Need to create a default project when creating user
    # TODO: Need a default list for each project, first saved

    collaborators = models.ManyToManyField(User, through='ProjectCollaborator')
    keywords = models.ManyToManyField(Keyword, related_name='projects')
    domains = models.ManyToManyField(Domain, related_name='projects')


    @classmethod
    def get_user_projects(cls, user):
        return cls.objects.filter(collaborators__id=user.id).all()


    def get_ongoing_submission(self):
        # Assume no more than one submission currently ongoing
        # TODO: Refactor hardcoded status
        submission = Submission.objects.filter(project=self, status='ONGOING').first()
        return submission


    @classmethod
    def get_default_project(cls, user):
        return cls.objects.filter(collaborators__id=user.id, 
                                  projectcollaborator__role='Creator', 
                                  is_default=True).first()


    def add_paper(self, paper, list_name='Default'):
        list_instance = ProjectList.objects.filter(project=self, name=list_name).first()
        pp_instance = ProjectPaper(list=list_instance, paper=paper)
        pp_instance.save()
        list_instance.projectpaper_set.add(pp_instance)
        list_instance.save()
        return pp_instance, list_instance


    def is_collaborator(self, user):
        return user in self.collaborators.all()


    def __str__(self):
        return f"{self.id}-{self.name}"


class ProjectCollaborator(models.Model):
    role = models.CharField(max_length=256, null=True, blank=True)
    collaborator = models.ForeignKey(User, on_delete=models.CASCADE, null=False)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False)


    def __str__(self):
        return f"{self.id}-{self.collaborator.username}...-{self.project.name}"


class ProjectList(models.Model):  # FIXME: Change name
    name = models.CharField(max_length=256, null=False)
    is_archived = models.BooleanField(default=False)

    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False, related_name='lists')

    def __str__(self):
        return f"{self.name}-{self.project.name}"


class Venue(models.Model):
    name = models.CharField(max_length=256)
    website = models.CharField(max_length=256, null=True, blank=True)
    start = models.DateTimeField()
    end = models.DateTimeField()

    reviewers = models.ManyToManyField(User, related_name='venues')
    keywords = models.ManyToManyField(Keyword, related_name='venues')
    domains = models.ManyToManyField(Domain, related_name='venues')


    @classmethod
    def get_venue_suggestions_for_project(cls, project_id):
        return cls.objects.filter(keywords__projects__id=project_id).distinct().all()


    def __str__(self):
        return f"{self.id}-{self.name}"


        
class Paper(models.Model):
    name = models.CharField(max_length=256)  # TODO: Add to ERD
    doi = models.CharField(max_length=256, null=True, blank=True, unique=True) 
    # FIXME: list_id not required
    abstract = models.TextField(default="", blank=True)
    authors = models.CharField(max_length=1024)

    keywords = models.ManyToManyField(Keyword, related_name='papers')
    venue = models.ForeignKey(Venue, on_delete=models.PROTECT, null=True)
    lists = models.ManyToManyField(ProjectList, through='ProjectPaper')


    def get_relevant_papers(self):
        # TODO: Handle if venue is none

        papers = Paper.objects.filter(
            Q(venue_id=self.venue_id) 
            | Q(keywords__papers__id=self.id)
        ).exclude(pk=self.id).distinct().all()

        return papers


    def __str__(self):
        return f"{self.id}-{self.name[:20]}..."


class ProjectPaper(models.Model):
    # TODO: Should be a relation between project - paper
    # But when a project is changed, the list must also be changed
    # TODO: List can be null (unlisted papers)
    date_added = models.DateTimeField(auto_now_add=True, blank=True)
    list = models.ForeignKey(ProjectList, on_delete=models.CASCADE, null=False)
    paper = models.ForeignKey(Paper, on_delete=models.PROTECT, null=False)


    def __str__(self):
        return f"{self.id}-{self.paper.name[:20]}...-{self.list.name}"


class Note(models.Model):
    project_paper = models.OneToOneField(
        ProjectPaper,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='note',
        db_column='id'
    )
    # TODO: How to use creator_id? Also fix `creator_id` to `creator`
    creator = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    # NOTE: visibility choices = ['Private', 'Public']
    text = models.TextField(default='', blank=True)
    visibility = models.CharField(max_length=64, default='Private', blank=True)
    last_modified = models.DateTimeField(auto_now_add=True, blank=True)


    def save(self, *args, **kwargs):
        self.last_modified = datetime.now()
        super(Note, self).save(*args, **kwargs)


    def __str__(self):
        return f"{str(self.project_paper)}-{self.visibility}"


@receiver(post_save, sender=ProjectPaper)
def create_project_paper_note(sender, instance, created, **kwargs):
    if created:
        Note.objects.create(project_paper=instance)


class Task(models.Model):
    name = models.CharField(max_length=256)
    start_date = models.DateTimeField(blank=True, null=True)
    due_date = models.DateTimeField(blank=True, null=True)
    status = models.CharField(max_length=128, default='Later', blank=True)

    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False, related_name='tasks')
    project_paper = models.ForeignKey(ProjectPaper, on_delete=models.CASCADE, 
                                      related_name='tasks', null=True, blank=True)
    assignees = models.ManyToManyField(ProjectCollaborator, related_name='tasks')


    def __str__(self):
        return f"{self.id}-{self.name}-{self.status}"


class TaskDependency(models.Model):
    after = models.ForeignKey(Task, on_delete=models.CASCADE, null=False, related_name='depends_on')
    before = models.ForeignKey(Task, on_delete=models.CASCADE, null=False, related_name='next')

    def __str__(self):
        return f"{self.before.id}-{self.before.name}-{self.after.id}-{self.after.name}"


class Conference(Venue):
    # TODO: how to handle same conf of different years?
    isbn = models.CharField(max_length=256, null=True, blank=True)


class Journal(Venue):
    issn = models.CharField(max_length=256, null=True, blank=True)


class Submission(models.Model):
    STATUS_CHOICES = [
        ('UPCOMING', 'Upcoming'),
        ('ONGOING', 'Ongoing'),
        ('ACCEPTED', 'Accepted'),
        ('REJECTED', 'Rejected'),
    ]

    name = models.CharField(max_length=256)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False)
    venue = models.ForeignKey(Venue, on_delete=models.PROTECT, null=True)
    # TODO: Change Ongoing after venue has passed
    status = models.CharField(max_length=128, blank=True, choices=STATUS_CHOICES)
    submitted = models.DateTimeField(null=True, blank=True, auto_now_add=True)

    reviewers = models.ManyToManyField(User, related_name='review_papers', blank=True)


    @property
    def is_ongoing(self):
        return self.status == 'ONGOING'


    def get_ongoing_activity(self):
        activity_list = VenueActivity.objects.filter(venue=self.venue).order_by('end').all()
        for activity in activity_list:
            if activity.start is None:
                return activity
            if timezone.now() >= activity.start:
                return activity
        return None


    def __str__(self):
        return f"{self.id}-p({self.project.name})-v({self.venue.name})"


class SubmissionComment(models.Model):
    # Type (Author/Reviewer)
    submission = models.ForeignKey(Submission, on_delete=models.PROTECT, related_name='comments')
    reviewer_thread = models.ForeignKey(User, on_delete=models.PROTECT, related_name=None)
    user = models.ForeignKey(User, on_delete=models.PROTECT, related_name='submission_comments')
    text = models.TextField()
    datetime = models.DateTimeField(auto_now_add=True)
    highlight_metadata = models.JSONField(null=True, blank=True)

    def __str__(self):
        return f"{self.id}-sub{self.submission.id}-{self.text[:20]}"


class VenueActivity(models.Model):
    venue = models.ForeignKey(Venue, on_delete=models.CASCADE, related_name='schedule')
    activity = models.CharField(max_length=256)
    start = models.DateTimeField(null=True, blank=True)
    end = models.DateTimeField()
    

    @property
    def is_ongoing(self):
        return (self.start is None or timezone.now() >= self.start) and timezone.now() < self.end

    def __str__(self):
        return f"{self.id}-{self.activity}-v({self.venue})"


class FileUpload(models.Model):
    STATUS_CHOICES = [
        ('DRAFT', 'Draft'),
        ('ACTIVE', 'Active'),
    ]
    CONTENT_CHOICES = [
        ('ABSTRACT', 'Abstract'),
        ('MANUSCRIPT', 'Manuscript'),
    ]

    file = models.FileField()
    upload_date = models.DateTimeField(auto_now_add=True, blank=True)
    content = models.CharField(max_length=64, choices=CONTENT_CHOICES, blank=False)
    status = models.CharField(max_length=64, choices=STATUS_CHOICES, default='DRAFT', blank=True)
    name = models.CharField(max_length=256)

    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False)
    uploader = models.ForeignKey(User, on_delete=models.CASCADE, null=False)

    def __str__(self):
        return f"{self.id}-{self.name}-{self.content}-p({self.project})"
