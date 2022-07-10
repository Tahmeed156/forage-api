from rest_framework.decorators import api_view, action
from rest_framework import status, viewsets, mixins
from rest_framework.response import Response
from api.models import Paper, Project
from api.serializers import PaperSerializer, ProjectListSerializer, ProjectSerializer, UserSerializer


class PaperViewset(viewsets.GenericViewSet, mixins.ListModelMixin):
    queryset = Paper.objects.all()
    serializer_class = PaperSerializer


class ProjectViewset(viewsets.GenericViewSet, mixins.ListModelMixin):
    serializer_class = ProjectSerializer


    def get_queryset(self):
        # Should return the projects for the user only
        return Project.get_user_projects(self.request.user)


    @action(detail=True, methods=['GET'])
    def collaborators(self, request, pk):
        clb = Project.objects.get(id=pk).collaborators
        serializer = UserSerializer(clb, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


    @action(detail=True, methods=['GET'])
    def lists(self, request, pk):
        clb = Project.objects.get(id=pk).lists
        serializer = ProjectListSerializer(clb, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
