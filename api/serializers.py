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
    class Meta:
        model = ProjectPaper
        fields = ('id', 'list_id', 'paper_id', 'date_added')


class ProjectSerializer(DynamicFieldsModelSerializer):
    collaborators = UserSerializer(fields=['id', 'username'], many=True)
    lists = ProjectListSerializer(fields=['id', 'name'], many=True)

    class Meta:
        model = Project
        fields = ('id', 'name', 'url', 'description', 'is_default', 'collaborators', 'lists')


class ProjectCollaboratorSerializer(DynamicFieldsModelSerializer):
    collaborator = UserSerializer(fields=['id', 'username'])

    class Meta:
        model = ProjectCollaborator
        fields = ('id', 'collaborator', 'role', 'project')


class TaskSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Task
        fields = ('id', 'name', 'status', 'start_date', 'due_date', 'assignees', 'project_paper')
