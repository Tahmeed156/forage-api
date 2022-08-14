from django.urls import include, path
from rest_framework.routers import DefaultRouter
from rest_framework_nested.routers import NestedSimpleRouter
from django.contrib import admin
from api import views
from rest_framework.authtoken.views import obtain_auth_token


router = DefaultRouter()
router.register(r'papers', views.PaperViewset)
router.register(r'projects', views.ProjectViewset, basename='Project')
router.register(r'tasks', views.TaskViewset, basename='Task')
router.register(r'notes', views.NoteViewset, basename='Note')

project_router = NestedSimpleRouter(router, r'projects', lookup='project')
project_router.register(r'lists', views.ProjectListViewset, basename='lists')
project_router.register(r'collaborators', views.ProjectCollaboratorViewset, basename='collaborators')
project_router.register(r'papers', views.ProjectPaperViewset, basename='papers')


urlpatterns = [
    path('api/', include(router.urls)),
    path('api/', include(project_router.urls)),
    path('api/test/', views.test_api, name='test-api'),

    path('extension/add-paper/', views.extension_add_paper, name='extension-add-paper'),
    path('extension/paper-to-project/', views.extension_paper_to_project, name='extension-paper-to-project'),
    path('extension/collaborator-to-paper/', views.extension_collaborator_to_paper, name='extension-collaborator-to-paper'),

    path('admin/', admin.site.urls),
    path('auth/token/', obtain_auth_token)
]