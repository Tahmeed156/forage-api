from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    date_of_birth = models.DateTimeField(null=True, blank=True)
    affiliation = models.CharField(max_length=256, null=True, blank=True)
    designation = models.CharField(max_length=256, null=True, blank=True)


class Project(models.Model):
    name = models.CharField(max_length=256)  # TODO: Add to ERD
    # FIXME: What is the purpose of the url
    url = models.CharField(max_length=256, null=True, blank=True)  
    description = models.TextField(default="", blank=True)
    # FIXME: Instead of is_default here, link default project in User model
    is_default = models.BooleanField(default=False, blank=True)  

    # TODO: Need to create a default project when creating user

    collaborators = models.ManyToManyField(User, through='ProjectCollaborator')

    @classmethod
    def get_user_projects(cls, user):
        return cls.objects.filter(collaborators__id=user.id).all()

    @classmethod
    def get_default_project(cls, user):
        # NOTE: Query projects to find my default project (user in collaborators, role='Creator', is_default=True)
        pass

    def __str__(self):
        return f"{self.id}-{self.name}"

class ProjectCollaborator(models.Model):
    role = models.CharField(max_length=256, null=True, blank=True)
    collaborator = models.ForeignKey(User, on_delete=models.CASCADE, null=False)
    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False)


class ProjectList(models.Model):  # FIXME: Change name
    name = models.CharField(max_length=256, null=False)
    is_archived = models.BooleanField(default=False)

    project = models.ForeignKey(Project, on_delete=models.CASCADE, null=False, related_name='lists')

    def __str__(self):
        return f"{self.name}-{self.project.name}"


class Paper(models.Model):
    name = models.CharField(max_length=256)  # TODO: Add to ERD
    doi = models.CharField(max_length=256, null=True, blank=True, unique=True) 
    # FIXME: list_id not required
    abstract = models.TextField(default="", blank=True)
    authors = models.CharField(max_length=1024)
    # TODO: Date published
    # TODO: Conference / Journal
    
    lists = models.ManyToManyField(ProjectList, through='ProjectPaper')

    def __str__(self):
        return f"{self.id}-{self.name[:20]}..."


class ProjectPaper(models.Model):
    # TODO: Should be a relation between project - paper
    # But when a project is changed, the list must also be changed
    # TODO: List can be null (unlisted papers)
    date_added = models.DateTimeField(auto_now_add=True, blank=True)
    list = models.ForeignKey(ProjectList, on_delete=models.CASCADE, null=False)
    paper = models.ForeignKey(Paper, on_delete=models.PROTECT, null=False)
