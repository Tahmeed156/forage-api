from django.urls import include, path
from rest_framework.routers import DefaultRouter
from rest_framework_nested.routers import NestedSimpleRouter
from django.contrib import admin
from api import views
from django.conf import settings
from django.conf.urls.static import static


router = DefaultRouter()
router.register(r'papers', views.PaperViewset)
router.register(r'projects', views.ProjectViewset, basename='Project')
router.register(r'submissions', views.SubmissionViewset, basename='Submission')
router.register(r'tasks', views.TaskViewset, basename='Task')
router.register(r'notes', views.NoteViewset, basename='Note')
router.register(r'venues', views.VenueViewset, basename='Venue')
router.register(r'files', views.FileUploadView, basename='File')
router.register(r'keywords', views.KeywordViewset, basename='Keyword')
router.register(r'domains', views.DomainViewset, basename='Domain')
router.register(r'users', views.UserViewset, basename='User')
router.register(r'proposals', views.ReviewerProposalViewset, basename='ReviewerProposal')

project_router = NestedSimpleRouter(router, r'projects', lookup='projects')
project_router.register(r'lists', views.ProjectListViewset, basename='lists')
project_router.register(r'collaborators', views.ProjectCollaboratorViewset, basename='collaborators')
project_router.register(r'papers', views.ProjectPaperViewset, basename='papers')
project_router.register(r'submissions', views.ProjectSubmissionViewset, basename='submissions')

submission_router = NestedSimpleRouter(router, r'submissions', lookup='submissions')
submission_router.register(r'comments', views.SubmissionCommentViewset, basename='comments')


urlpatterns = [
    path('api/', include(router.urls)),
    path('api/', include(project_router.urls)),
    path('api/', include(submission_router.urls)),
    path('api/test/', views.test_api, name='test-api'),

    path('extension/add-paper/', views.extension_add_paper, name='extension-add-paper'),
    path('extension/paper-to-project/', views.extension_paper_to_project, name='extension-paper-to-project'),
    path('extension/collaborator-to-paper/', views.extension_collaborator_to_paper, name='extension-collaborator-to-paper'),

    path('admin/', admin.site.urls),
    path('auth/token/', views.ForageAuthToken.as_view()),

] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)