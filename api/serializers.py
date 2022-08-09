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


class VenueSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Venue
        fields = ('id', 'name', 'website')


class KeywordSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Keyword
        fields = ('id', 'name')


class PaperKeywordSerializer(DynamicFieldsModelSerializer):
    paper = serializers.SlugRelatedField(read_only=True, slug_field='name')
    
    class Meta:
        model = PaperKeyword
        fields = ('paper', 'keyword')
        

class PaperSerializer(DynamicFieldsModelSerializer):
    venue = VenueSerializer(fields=['name'])
    keywords = PaperKeywordSerializer(many=True)

    class Meta:
        model = Paper
        fields = ('id', 'name', 'doi', 'abstract', 'authors', 'venue', 'keywords')


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

    class Meta:
        model = Project
        fields = ('id', 'name', 'url', 'description', 'is_default', 'collaborators', 'lists')


class ProjectCollaboratorSerializer(DynamicFieldsModelSerializer):
    collaborator = UserSerializer(fields=['id', 'username'])

    class Meta:
        model = ProjectCollaborator
        fields = ('id', 'collaborator', 'role', 'project')


class TaskSerializer(DynamicFieldsModelSerializer):
    project_paper = ProjectPaperSerializer(fields=['id', 'paper'])
    project = ProjectSerializer(fields=['id', 'name'])

    class Meta:
        model = Task
        fields = ('id', 'name', 'status', 'start_date', 'due_date', 'assignees', 'project_paper', 'project')


class ConferenceSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Conference
        fields = VenueSerializer.Meta.fields + ('isbn',)


class JournalSerializer(DynamicFieldsModelSerializer):
    class Meta:
        model = Journal
        fields = VenueSerializer.Meta.fields + ('issn',)

