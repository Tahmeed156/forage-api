from rest_framework.decorators import api_view, action
from rest_framework import status, viewsets, mixins
from rest_framework.response import Response
from api.models import Paper, Project
from api.serializers import PaperSerializer, ProjectListSerializer, ProjectSerializer, UserSerializer


class PaperViewset(viewsets.GenericViewset, mixins.ListModelMixin):
    queryset = Paper.objects.all()
    serializer_class = PaperSerializer


class ProjectViewset(viewsets.GenericViewset, mixins.ListModelMixin):
    serializer_class = ProjectSerializer


    def get_queryset(self):
        # Should return the projects for the user only
        return Project.get_user_projects(self.request.user)




