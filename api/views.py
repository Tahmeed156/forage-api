from rest_framework.decorators import api_view, action
from rest_framework import status, viewsets, mixins, exceptions
from rest_framework.response import Response
from api.models import Paper, Project, ProjectList, ProjectPaper
from api.serializers import PaperSerializer, ProjectListSerializer, ProjectPaperSerializer, ProjectSerializer, UserSerializer


@api_view(['POST'])
def extension_add_paper(request):
    data = request.data

    #  Search if paper currently exists, if not then create 
    paper = Paper.objects.filter(doi=data.get('doi')).first()
    print(paper, data)
    if paper is None:
        paper = Paper(
            name=data.get('name'),
            doi=data.get('doi'),
            abstract=data.get('abstract'),
            authors=data.get('authors'),
        )
        paper.save()

    # Add to default project i.e. unsorted (for that user)
    project = Project.get_default_project(request.user)
    print(project)
    pp_instance, _ = project.add_paper(paper, 'Default')

    return Response({"ppid": pp_instance.id}, status=status.HTTP_201_CREATED)


@api_view(['POST'])
def extension_paper_to_project(request):
    data = request.data

    pp_instance = ProjectPaper.objects.get(id=data.get("ppid"))
    pl_instance = ProjectList.objects.get(id=data.get("list_id"), 
                                          project_id=data.get("project_id"))

    if not pl_instance.project.is_collaborator(request.user):
        raise exceptions.PermissionDenied("User not in project")

    pp_instance.list = pl_instance
    pp_instance.save()

    serializer = ProjectPaperSerializer(pp_instance)
    return Response(serializer.data, status=status.HTTP_200_OK)


def extension_add_collaborator_to_paper():
    pass


class PaperViewset(viewsets.GenericViewSet,
                   mixins.ListModelMixin,
                   mixins.RetrieveModelMixin):
    queryset = Paper.objects.all()
    serializer_class = PaperSerializer


    @action(detail=False, methods=['GET'])
    def unsorted(self, request):
        project_instance = Project.get_default_project(request.user)
        list_instance = project_instance.lists.first()

        serializer = PaperSerializer(list_instance.paper_set.all(), many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProjectViewset(viewsets.GenericViewSet, 
                     mixins.ListModelMixin,
                     mixins.RetrieveModelMixin):
    serializer_class = ProjectSerializer


    def get_queryset(self):
        # Should return the projects for the user only
        return Project.get_user_projects(self.request.user)


    @action(detail=True, methods=['GET'])
    def collaborators(self, request, pk):
        clb = Project.objects.get(id=pk).collaborators
        serializer = UserSerializer(clb, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProjectListViewset(viewsets.GenericViewSet, 
                         mixins.ListModelMixin, 
                         mixins.RetrieveModelMixin):
    serializer_class = ProjectListSerializer

    def get_queryset(self):
        return ProjectList.objects.filter(project_id=self.kwargs['project_pk'])

    @action(detail=True, methods=['GET'])
    def papers(self, request, project_pk, pk):
        project_list_instance= ProjectList.objects.get(id=pk)

        print(project_list_instance.project_id, project_pk, pk)
        if project_list_instance.project_id != int(project_pk):
            raise exceptions.PermissionDenied("List not in project")

        paper_instances = project_list_instance.paper_set.all()
        serializer = PaperSerializer(paper_instances, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
