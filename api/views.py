from rest_framework.decorators import api_view, action, authentication_classes, permission_classes
from rest_framework import status, viewsets, mixins, exceptions, filters
from rest_framework.response import Response
from api.models import *
from api.serializers import *

@api_view(['POST'])
def extension_add_paper(request):
    data = request.data

    #  Search if paper currently exists, if not then create 
    paper = Paper.objects.filter(doi=data.get('doi')).first()
    venue = Venue.objects.filter(name=data.get('venue')).first()

    if not venue:
        if data.get('venue_type') == 'conference':
            venue = Conference(name=data.get('venue'), website=data.get('venue_website'))
        # elif data.get('venue_type') == 'journal':
        else:
            venue = Journal(name=data.get('venue'), website=data.get('venue_website'))
        venue.save()

    if paper is None:
        paper = Paper(
            name=data.get('name'),
            doi=data.get('doi'),
            abstract=data.get('abstract'),
            authors=data.get('authors'),
            venue=venue
        )
        paper.save()

    # Add keywords to paper
    if data.get('keywords'):
        for k in data.get('keywords'):
            k = k.lower()
            keyword, created = Keyword.objects.get_or_create(name=k)
            if created:
                keyword.save()
            paper.keywords.add(keyword)
            paper.save()

    # Add to default project i.e. unsorted (for that user)
    project = Project.get_default_project(request.user)
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


@api_view(['POST'])
def extension_collaborator_to_paper(request):
    # TODO: Check whether collaborator in project
    data = request.data

    pp_instance = ProjectPaper.objects.get(id=data.get("ppid"))
    pc_instance = ProjectCollaborator.objects.get(id=data.get("pcid"))

    task = Task(
        name='Read paper',
        status='Next',
        project=pp_instance.list.project,
        project_paper=pp_instance,
    )
    task.save()
    task.assignees.add(pc_instance)

    serializer = TaskSerializer(task)
    return Response(serializer.data, status=status.HTTP_201_CREATED)


@api_view(['GET'])    
@authentication_classes([])
@permission_classes([])
def test_api(request):
   return Response({ "message": "Successfully accessed API" })


class PaperViewset(viewsets.GenericViewSet,
                   mixins.ListModelMixin,
                   mixins.RetrieveModelMixin):
    queryset = Paper.objects.all()
    serializer_class = PaperSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['name', 'authors']


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


class ProjectListViewset(viewsets.GenericViewSet, 
                         mixins.ListModelMixin, 
                         mixins.RetrieveModelMixin):
    serializer_class = ProjectListSerializer

    def get_queryset(self):
        return ProjectList.objects.filter(project_id=self.kwargs['projects_pk'])

    @action(detail=True, methods=['GET'])
    def papers(self, request, project_pk, pk):
        project_list_instance= ProjectList.objects.get(id=pk)

        print(project_list_instance.project_id, project_pk, pk)
        if project_list_instance.project_id != int(project_pk):
            raise exceptions.PermissionDenied("List not in project")

        paper_instances = project_list_instance.paper_set.all()
        serializer = PaperSerializer(paper_instances, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProjectCollaboratorViewset(viewsets.GenericViewSet, 
                                 mixins.ListModelMixin, 
                                 mixins.RetrieveModelMixin):
    serializer_class = ProjectCollaboratorSerializer

    def get_queryset(self):
        return ProjectCollaborator.objects.filter(project_id=self.kwargs['projects_pk'])

    @action(detail=True, methods=['GET'])
    def tasks(self, request, project_pk, pk):
        project_clb_instance = ProjectCollaborator.objects.get(id=pk)

        print(project_clb_instance.project_id, project_pk, pk)
        if project_clb_instance.project_id != int(project_pk):
            raise exceptions.PermissionDenied("Collaborator not in project")

        task_instances = project_clb_instance.tasks.all()
        serializer = TaskSerializer(task_instances, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class TaskViewset(viewsets.ModelViewSet):
    serializer_class = TaskSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['name', 'project__name', 'project_paper__paper__name']


    def get_queryset(self):
        return Task.objects.filter(project__collaborators__id=self.request.user.id)

    
    @action(detail=True, methods=['POST', 'DELETE'])
    def depends_on(self, request, pk):
        if request.method == 'POST':
            # TODO: Validation

            # Check if already exists
            task_dep_instance = TaskDependency.objects.filter(
                before_id=request.data.get('dep_id'),
                after_id=pk
            ).first()
            if task_dep_instance is not None:
                raise exceptions.APIException('Dependency already exists')

            # Link dependency
            task_dep_instance = TaskDependency(
                before_id=request.data.get('dep_id'),
                after_id=pk
            )
            task_dep_instance.save()

            serializer = TaskDependencySerializer(task_dep_instance)
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        elif request.method == 'DELETE':
            # TODO: Validation

            task_dep_instance = TaskDependency.objects.filter(
                before_id=request.data.get('dep_id'),
                after_id=pk
            ).first()
            if task_dep_instance is None:
                raise exceptions.NotFound()
            task_dep_instance.delete()

            return Response({}, status=status.HTTP_204_NO_CONTENT)

        else:
            raise exceptions.MethodNotAllowed()


class NoteViewset(viewsets.GenericViewSet, 
                  mixins.UpdateModelMixin, 
                  mixins.RetrieveModelMixin,
                  mixins.ListModelMixin):
    serializer_class = NoteSerializer
    queryset = Note.objects.all()
    filterset_fields = ['project_paper__paper']

    # TODO: Add API for public notes under paper
    # TODO: Restrict update to only user notes (not any/public notes)
    # def get_queryset(self):
    #     # return Note.objects.filter(project_paper__list__project__collaborators__id=self.request.user.id)
    #     return Note.objects.filter(visibility='Public')


class ProjectPaperViewset(viewsets.GenericViewSet, 
                         mixins.ListModelMixin, 
                         mixins.RetrieveModelMixin):
    serializer_class = ProjectPaperSerializer

    def get_queryset(self):
        return ProjectPaper.objects.filter(list__project__id=self.kwargs['projects_pk'])


class VenueViewset(viewsets.GenericViewSet, 
                   mixins.ListModelMixin,
                   mixins.RetrieveModelMixin):
    serializer_class = VenueSerializer
    queryset = Venue.objects.all()


class SubmissionViewset(viewsets.GenericViewSet, 
                        mixins.ListModelMixin, 
                        mixins.RetrieveModelMixin):
    serializer_class = SubmissionSerializer
    filterset_fields = ['project']


    def get_queryset(self):
        return Submission.objects.filter(project__collaborators__id=self.request.user.id)


class SubmissionCommentViewset(viewsets.GenericViewSet, 
                               mixins.ListModelMixin, 
                               mixins.CreateModelMixin, 
                               mixins.RetrieveModelMixin):
    serializer_class = SubmissionCommentSerializer

    def get_queryset(self):
        return SubmissionComment.objects.filter(submission_id=self.kwargs['submissions_pk'])
