from django.urls import include, path
from rest_framework.routers import DefaultRouter
from rest_framework_nested.routers import NestedSimpleRouter
from django.contrib import admin
from api import views
from rest_framework.authtoken.views import obtain_auth_token


router = DefaultRouter()
router.register(r'papers', views.PaperViewset)
router.register(r'projects', views.ProjectViewset, basename='Project')


project_router = NestedSimpleRouter(router, r'projects', lookup='project')
project_router.register(r'lists', views.ProjectListViewset, basename='lists')


urlpatterns = [
    path('api/', include(router.urls)),
    path('api/', include(project_router.urls)),

    path('extension/add-paper/', views.extension_add_paper, name='extension-add-paper'),

    path('admin/', admin.site.urls),
    path('auth/token/', obtain_auth_token)
]