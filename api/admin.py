from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from api.models import User, Paper, Project, ProjectList, ProjectCollaborator, ProjectPaper

admin.site.register(User, UserAdmin)
admin.site.register(Paper)
admin.site.register(Project)
admin.site.register(ProjectCollaborator)
admin.site.register(ProjectList)
admin.site.register(ProjectPaper)

