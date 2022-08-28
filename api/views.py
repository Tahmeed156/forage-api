from rest_framework.decorators import api_view, action, authentication_classes, permission_classes
from rest_framework import status, viewsets, mixins, exceptions, filters
from rest_framework.response import Response
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
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


    @action(detail=True, methods=['GET'])
    def relevant(self, request, pk):
        paper_instances = Paper.objects.get(id=pk).get_relevant_papers()

        serializer = PaperSerializer(paper_instances, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProjectViewset(viewsets.GenericViewSet, 
                     mixins.CreateModelMixin,
                     mixins.ListModelMixin,
                     mixins.UpdateModelMixin,
                     mixins.RetrieveModelMixin):
    serializer_class = ProjectSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['name', 'collaborators__username']


    def get_queryset(self):
        # Should return the projects for the user only
        return Project.get_user_projects(self.request.user)


    def create(self, request):
        data = request.data

        # Create project
        project = Project(
            name=data.get('name'),
            description=data.get('description')
        )
        project.save()

        # Create some lists by default
        for list_name in ['Done', 'Next']:
            project_list = ProjectList(
                name=list_name,
                project=project
            )
            project_list.save()

        # Add collaborators to project
        for colab_id in data.get('collaborators'):
            user = User.objects.get(id=colab_id)
            project_collaborator = ProjectCollaborator(
                collaborator=user,
                project=project,
                role='Researcher'
            )
            project_collaborator.save()

        # Add keywords to project
        for keyword_id in data.get('keywords'):
            k = Keyword.objects.get(id=keyword_id)
            project.keywords.add(k)

        # Add domains to project
        for domain_id in data.get('domains'):
            d = Domain.objects.get(id=domain_id)
            project.domains.add(d)

        serializer = ProjectSerializer(project)
        return Response(serializer.data, status=status.HTTP_201_CREATED)


class ProjectListViewset(viewsets.GenericViewSet, 
                         mixins.ListModelMixin, 
                         mixins.CreateModelMixin, 
                         mixins.DestroyModelMixin, 
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
    def assignees(self, request, pk):
        if request.method == 'POST':
            task_ins = Task.objects.get(id=pk)
            colab = ProjectCollaborator.objects.get(id=request.data.get('colab_id'))

            task_ins.assignees.add(colab)
            task_ins.save()
            
            serializer = TaskSerializer(task_ins)
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        elif request.method == 'DELETE':
            task_ins = Task.objects.get(id=pk)
            colab = ProjectCollaborator.objects.get(id=request.data.get('colab_id'))

            task_ins.assignees.remove(colab)
            task_ins.save()
            
            return Response({}, status=status.HTTP_204_NO_CONTENT)

    
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

            serializer = BeforeTaskSerializer(task_dep_instance)
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
                         mixins.UpdateModelMixin, 
                         mixins.RetrieveModelMixin):
    serializer_class = ProjectPaperSerializer

    def get_queryset(self):
        return ProjectPaper.objects.filter(list__project__id=self.kwargs['projects_pk'])


class ProjectSubmissionViewset(viewsets.GenericViewSet, 
                               mixins.ListModelMixin, 
                               mixins.RetrieveModelMixin):
    serializer_class = SubmissionSerializer
    ordering_fields = ['venue', 'venue__start', 'venue__end']
    ordering = ['venue__end']


    def get_queryset(self):
        return Submission.objects.filter(project__id=self.kwargs['projects_pk'])


    @action(detail=False, methods=['GET'])
    def ongoing(self, request, projects_pk):
        sub_instance = Project.objects.get(id=projects_pk).get_ongoing_submission()

        serializer = SubmissionSerializer(sub_instance)
        return Response(serializer.data, status=status.HTTP_200_OK)


class VenueViewset(viewsets.GenericViewSet, 
                   mixins.ListModelMixin,
                   mixins.RetrieveModelMixin):
    serializer_class = VenueSerializer
    queryset = Venue.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']


    @action(detail=False, methods=['GET'])
    def suggest(self, request):
        venues = Venue.get_venue_suggestions_for_project(request.GET.get('project_id'))

        serializer = VenueSerializer(venues, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class SubmissionViewset(viewsets.GenericViewSet, 
                        mixins.CreateModelMixin,
                        mixins.ListModelMixin, 
                        mixins.DestroyModelMixin, 
                        mixins.RetrieveModelMixin):
    serializer_class = SubmissionSerializer
    filterset_fields = ['project', 'reviewers']
    ordering_fields = ['venue', 'venue__start', 'venue__end']
    ordering = ['venue__end']


    def get_queryset(self):
        return Submission.objects.filter(project__collaborators__id=self.request.user.id)


class SubmissionCommentViewset(viewsets.GenericViewSet, 
                               mixins.ListModelMixin, 
                               mixins.CreateModelMixin, 
                               mixins.RetrieveModelMixin):
    serializer_class = SubmissionCommentSerializer
    ordering = ['-datetime']
    filterset_fields = ['reviewer_thread']


    def get_queryset(self):
        return SubmissionComment.objects.filter(submission_id=self.kwargs['submissions_pk'], parent_id=None)


class FileUploadView(viewsets.GenericViewSet, 
                     mixins.ListModelMixin, 
                     mixins.RetrieveModelMixin, 
                     mixins.CreateModelMixin,):
    serializer_class = FileUploadSerializer
    filterset_fields = ['content', 'status', 'project', 'uploader']
    queryset = FileUpload.objects.all()

    def create(self, request):
        file_uploaded = request.FILES.get('file')
        content_type = file_uploaded.content_type
        print(file_uploaded, content_type)

        return super().create(request)


    @action(detail=True, methods=['PUT'])
    def set_active(self, request, pk):
        file_upload_new = FileUpload.objects.get(id=pk)

        # Set all others under project as draft
        file_upload_actives = FileUpload.objects.filter(
            project_id=file_upload_new.project_id,
            content=file_upload_new.content,
            status='ACTIVE'
        ).all()
        for fu in file_upload_actives:
            fu.status = 'DRAFT'
            fu.save()

        file_upload_new.status = 'ACTIVE'
        file_upload_new.save()

        return Response({}, status=status.HTTP_204_NO_CONTENT)


class KeywordViewset(viewsets.GenericViewSet, 
                     mixins.CreateModelMixin,
                     mixins.ListModelMixin,
                     mixins.RetrieveModelMixin):
    serializer_class = KeywordSerializer
    queryset = Keyword.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']


class DomainViewset(viewsets.GenericViewSet, 
                    mixins.CreateModelMixin,
                    mixins.ListModelMixin,
                    mixins.RetrieveModelMixin):
    serializer_class = DomainSerializer
    queryset = Domain.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['name']


class UserViewset(viewsets.GenericViewSet, 
                  mixins.CreateModelMixin,
                  mixins.ListModelMixin,
                  mixins.RetrieveModelMixin):
    serializer_class = UserSerializer
    queryset = User.objects.all()
    filter_backends = [filters.SearchFilter]
    search_fields = ['username']


class ForageAuthToken(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, _ = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user': UserSerializer(user).data
        })


class ReviewerProposalViewset(viewsets.GenericViewSet, 
                              mixins.CreateModelMixin,
                              mixins.ListModelMixin, 
                              mixins.RetrieveModelMixin):
    serializer_class = ReviewerProposalSerializer
    filterset_fields = ['reviewer_id', 'venue_id']
    search_fields = ['username']


    def get_queryset(self):
        return ReviewerProposal.objects.filter(reviewer=self.request.user).all()


    @action(detail=True, methods=['POST'])
    def reject(self, request, pk):
        proposal_instance = ReviewerProposal.objects.get(id=pk)

        if proposal_instance.status != 'RECEIVED':
            raise exceptions.APIException("Proposal already accepted/rejected")

        proposal_instance.status = 'REJECTED'
        proposal_instance.save()

        serializer = ReviewerProposalSerializer(proposal_instance)
        return Response(serializer.data, status=status.HTTP_200_OK)


    @action(detail=True, methods=['POST'])
    def accept(self, request, pk):
        proposal_instance = ReviewerProposal.objects.get(id=pk)

        if proposal_instance.status != 'RECEIVED':
            raise exceptions.APIException("Proposal already accepted/rejected")

        proposal_instance.venue.reviewers.add(proposal_instance.reviewer)

        proposal_instance.status = 'ACCEPTED'
        proposal_instance.save()

        serializer = ReviewerProposalSerializer(proposal_instance)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ReviewerViewset(viewsets.GenericViewSet,
                      mixins.ListModelMixin, 
                      mixins.RetrieveModelMixin, 
                      mixins.UpdateModelMixin):
    serializer_class = ReviewerSerializer
    filterset_fields = ['user_id', 'submission_id', 'is_submitted']


    def get_queryset(self):
        return Reviewer.objects.filter(user=self.request.user).all()

