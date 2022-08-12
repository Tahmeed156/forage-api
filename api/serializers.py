from rest_framework import serializers
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
    class Meta:
        model = Paper
        fields = ('id', 'name', 'doi', 'abstract', 'authors')


class UserSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'date_of_birth', 'affiliation', 'designation')


class ProjectListSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = ProjectList
        fields = ('id', 'name', 'is_archived')


class ProjectPaperSerializer(DynamicFieldsModelSerializer):
    paper = serializers.SlugRelatedField(read_only=True, slug_field='name')

    class Meta:
        model = ProjectPaper
        fields = ('id', 'list_id', 'paper', 'paper_id', 'date_added')


class ProjectSerializer(DynamicFieldsModelSerializer):
    collaborators = UserSerializer(fields=['id', 'username'], many=True)
    lists = ProjectListSerializer(fields=['id', 'name'], many=True)
    tasks = serializers.SerializerMethodField()

    def get_tasks(self, instance):
        from api.serializers import TaskSerializer
        return TaskSerializer(instance.tasks, many=True).data

    class Meta:
        model = Project
        fields = ('id', 'name', 'url', 'description', 'is_default', 'collaborators', 'lists', 'tasks')


class ProjectCollaboratorSerializer(DynamicFieldsModelSerializer):
    collaborator = UserSerializer(fields=['id', 'username'])

    class Meta:
        model = ProjectCollaborator
        fields = ('id', 'collaborator', 'role', 'project')


class DependentTaskSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Task
        fields = ('name', 'project_paper')


class TaskDependencySerializer(DynamicFieldsModelSerializer):
    before = serializers.SlugRelatedField(read_only=True, slug_field='name')
    after = serializers.SlugRelatedField(read_only=True, slug_field='name')

    class Meta:
        model = TaskDependency
        fields = ('before', 'after')


class TaskSerializer(DynamicFieldsModelSerializer):
    project_paper = ProjectPaperSerializer(fields=['id', 'paper'], read_only=True)
    project_paper_id = serializers.IntegerField(write_only=True, allow_null=True)
    project = ProjectSerializer(fields=['id', 'name'], read_only=True)
    project_id = serializers.IntegerField(write_only=True)

    depends_on = TaskDependencySerializer(fields=['before'], read_only=True, many=True)
    next = TaskDependencySerializer(fields=['after'], read_only=True, many=True)

    class Meta:
        model = Task
        fields = ('id', 'name', 'status', 'start_date', 'due_date', 'project_paper', 'project', 
                  'depends_on', 'next', 'project_id', 'project_paper_id')