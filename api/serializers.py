from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from api.models import *

class DynamicFieldsModelSerializer(serializers.ModelSerializer):
    """ Helper class to select fields dynamically via parameters """

    def __init__(self, *args, **kwargs):
        fields = kwargs.pop('fields', None)

        super(DynamicFieldsModelSerializer, self).__init__(*args, **kwargs)

        if fields is not None:
            allowed = set(fields)
            existing = set(self.fields)
            for field_name in existing - allowed:
                self.fields.pop(field_name)


class PaperSerializer(DynamicFieldsModelSerializer):
    venue = serializers.SlugRelatedField(read_only=True, slug_field='name')
    venue_id = serializers.IntegerField(write_only=True)
    keywords = serializers.SlugRelatedField(read_only=True, slug_field='name', many=True)


    class Meta:
        model = Paper
        fields = ('id', 'name', 'doi', 'abstract', 'authors', 'venue', 'venue_id', 'keywords')


class KeywordSerializer(DynamicFieldsModelSerializer):


    class Meta:
        model = Keyword
        fields = ('id', 'name')


class DomainSerializer(DynamicFieldsModelSerializer):


    class Meta:
        model = Domain
        fields = ('id', 'name')



class UserSerializer(DynamicFieldsModelSerializer):
    password = serializers.CharField(write_only=True)


    def create(self, validated_data):
        validated_data['password'] = make_password(validated_data['password'])
        return super().create(validated_data)


    class Meta:
        model = User
        fields = ('id', 'username', 'full_name', 'affiliation', 'designation', 'email', 
                  'date_of_birth', 'password')


class ProjectListSerializer(DynamicFieldsModelSerializer):
    project_id = serializers.IntegerField(write_only=True)

    class Meta:
        model = ProjectList
        fields = ('id', 'name', 'is_archived', 'project_id')


class ProjectPaperSerializer(DynamicFieldsModelSerializer):
    paper = PaperSerializer(fields=['id', 'name', 'authors', 'status'], read_only=True)
    # paper_id = serializers.IntegerField(write_only=True, allow_null=True)
    list = serializers.SlugRelatedField(read_only=True, slug_field='name')
    list_id = serializers.IntegerField(write_only=True)
    tasks = serializers.SerializerMethodField(read_only=True)


    def get_tasks(self, instance):
        from api.serializers import TaskSerializer
        return TaskSerializer(instance.tasks, fields=['id', 'name'], many=True).data


    class Meta:
        model = ProjectPaper
        fields = ('id', 'list', 'list_id', 'paper', 'date_added', 'tasks')


class ProjectSerializer(DynamicFieldsModelSerializer):
    collaborators = UserSerializer(fields=['id', 'username'], many=True, read_only=True)
    lists = ProjectListSerializer(fields=['id', 'name'], many=True, read_only=True)
    tasks = serializers.SerializerMethodField()
    keywords = serializers.SlugRelatedField(read_only=True, slug_field='name', many=True)
    domains = serializers.SlugRelatedField(read_only=True, slug_field='name', many=True)


    def get_tasks(self, instance):
        from api.serializers import TaskSerializer
        return TaskSerializer(instance.tasks, many=True).data

    class Meta:
        model = Project
        fields = ('id', 'name', 'url', 'description', 'is_default', 'collaborators', 'lists', 'tasks', 
                  'domains', 'keywords')


class ProjectCollaboratorSerializer(DynamicFieldsModelSerializer):
    collaborator = UserSerializer(fields=['id', 'username', 'full_name'])

    class Meta:
        model = ProjectCollaborator
        fields = ('id', 'collaborator', 'role', 'project')


class DependentTaskSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Task
        fields = ('name', 'project_paper')


class BeforeTaskSerializer(DynamicFieldsModelSerializer):
    before = serializers.SerializerMethodField()

    def to_representation(self, instance):
        data = super().to_representation(instance)
        return data.get('before')

    def get_before(self, instance):
        from api.serializers import TaskSerializer
        return TaskSerializer(instance.before, fields=['id', 'name']).data

    class Meta:
        model = TaskDependency
        fields = ('before', 'after')


class AfterTaskSerializer(DynamicFieldsModelSerializer):
    after = serializers.SerializerMethodField()

    def to_representation(self, instance):
        data = super().to_representation(instance)
        return data.get('after')

    def get_after(self, instance):
        from api.serializers import TaskSerializer
        return TaskSerializer(instance.after, fields=['id', 'name']).data

    class Meta:
        model = TaskDependency
        fields = ('before', 'after')


class TaskSerializer(DynamicFieldsModelSerializer):
    project_paper = ProjectPaperSerializer(fields=['id', 'paper'], read_only=True)
    project_paper_id = serializers.IntegerField(write_only=True, allow_null=True)
    project = ProjectSerializer(fields=['id', 'name'], read_only=True)
    project_id = serializers.IntegerField(write_only=True)
    assignees = ProjectCollaboratorSerializer(read_only=True, many=True)

    depends_on = BeforeTaskSerializer(fields=['before'], read_only=True, many=True)
    next = AfterTaskSerializer(fields=['after'], read_only=True, many=True)

    class Meta:
        model = Task
        fields = ('id', 'name', 'status', 'start_date', 'due_date', 'project_paper', 'project', 
                  'depends_on', 'next', 'project_id', 'project_paper_id', 'assignees')


class NoteSerializer(DynamicFieldsModelSerializer):
    id = serializers.SerializerMethodField()
    project_collaborators = serializers.SerializerMethodField()


    def get_project_collaborators(self, instance):
        return UserSerializer(instance.project_paper.list.project.collaborators, fields=['id', 'username'], many=True).data


    def get_id(self, instance):
        return instance.project_paper_id


    class Meta:
        model = Note
        fields = ('id', 'text', 'visibility', 'last_modified', 'project_paper', 'project_collaborators')


class VenueActivitySerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = VenueActivity
        fields = ('id', 'activity', 'start', 'end')


class VenueSerializer(DynamicFieldsModelSerializer):
    reviewers = UserSerializer(fields=['id', 'username'], many=True)
    activities = serializers.SerializerMethodField()

    def get_activities(self, instance):
        schedule = instance.schedule.all().order_by('end')
        return VenueActivitySerializer(schedule, many=True).data

    class Meta:
        model = Venue
        fields = ('id', 'name', 'website', 'reviewers', 'activities')


class ConferenceSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Conference
        fields = VenueSerializer.Meta.fields + ('isbn',)


class JournalSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Journal
        fields = VenueSerializer.Meta.fields + ('issn',)


class SubmissionReplySerializer(DynamicFieldsModelSerializer):
    user = UserSerializer(fields=['id', 'username', 'full_name'], read_only=True)
    submission_id = serializers.IntegerField(write_only=True)
    parent_id = serializers.IntegerField(write_only=True, allow_null=True)

    def create(self, validated_data):
        validated_data['user'] = self.context.get('request').user
        return super().create(validated_data)

    class Meta:
        model = SubmissionComment
        fields = ('id', 'user', 'text', 'submission_id', 'reviewer_thread', 'parent_id', 'datetime', 'highlight_metadata')


class SubmissionCommentSerializer(SubmissionReplySerializer):
    replies = SubmissionReplySerializer(read_only=True, many=True)


    class Meta:
        model = SubmissionComment
        fields = SubmissionReplySerializer.Meta.fields + ('replies',)


class SubmissionSerializer(DynamicFieldsModelSerializer):
    project = ProjectSerializer(fields=['id', 'name'], read_only=True)
    project_id = serializers.IntegerField(write_only=True)
    venue = VenueSerializer(fields=['id', 'name', 'website'], read_only=True)
    venue_id = serializers.IntegerField(write_only=True)
    # comments = SubmissionCommentSerializer(fields=['id', 'user', 'text'], read_only=True, many=True)
    reviewers = UserSerializer(fields=['id', 'username', 'full_name'], many=True, read_only=True)
    activities = serializers.SerializerMethodField()
    ongoing_activity = serializers.SerializerMethodField()
    abstract = serializers.SerializerMethodField()
    manuscript = serializers.SerializerMethodField()


    def get_manuscript(self, instance):
        file_upload = instance.project.files.filter(content='MANUSCRIPT', status='ACTIVE').first()
        if file_upload is None:
            return ""
        return file_upload.file.url


    def get_abstract(self, instance):
        file_upload = instance.project.files.filter(content='ABSTRACT', status='ACTIVE').first()
        if file_upload is None:
            return ""
        return file_upload.file.url


    def get_activities(self, instance):
        activity_instances = instance.venue.schedule.all()
        return VenueActivitySerializer(activity_instances, many=True).data


    def get_ongoing_activity(self, instance):
        activity_instance = instance.get_ongoing_activity()
        return VenueActivitySerializer(activity_instance).data


    class Meta:
        model = Submission
        fields = ('id', 'name', 'project', 'project_id', 'venue', 'venue_id', 'status', 
                  'submitted', 'reviewers', 'activities', 'ongoing_activity', 'abstract', 'manuscript')


class FileUploadSerializer(DynamicFieldsModelSerializer):
    file = serializers.FileField()
    project = ProjectSerializer(fields=['id', 'name'], read_only=True)
    project_id = serializers.IntegerField(write_only=True)
    uploader = UserSerializer(fields=['id', 'username'], read_only=True)


    def create(self, validated_data):
        validated_data['uploader'] = self.context.get('request').user
        return super().create(validated_data)


    class Meta:
        model = FileUpload
        fields = ('id', 'file', 'upload_date', 'status', 'content', 'name', 'project', 'project_id', 'uploader')


class ReviewerProposalSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = ReviewerProposal
        fields = ('id', 'reviewer', 'venue', 'sent', 'status')


class ReviewerSerializer(DynamicFieldsModelSerializer):
    submission = SubmissionSerializer(fields=['id', 'name', 'project', 'venue', 'abstract', 'manuscript'])

    class Meta:
        model = Reviewer
        fields = ('id', 'user', 'submission', 'submission_id', 'review', 'is_submitted', 'submit_date')
