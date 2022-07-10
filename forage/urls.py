from django.urls import include, path
from rest_framework import routers
from django.contrib import admin
from api import views
from rest_framework.authtoken.views import obtain_auth_token


router = routers.DefaultRouter()
router.register(r'papers', views.PaperViewset)
router.register(r'projects', views.ProjectViewset, basename='Project')

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('api/', include(router.urls)),

    path('extension/add-paper/', views.extension_add_paper, name='extension-add-paper'),

    path('admin/', admin.site.urls),
    path('auth/token/', obtain_auth_token)
]