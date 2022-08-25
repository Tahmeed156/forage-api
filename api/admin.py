from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from api.models import *

admin.site.register(User, UserAdmin)
admin.site.register(Paper)
admin.site.register(Project)
admin.site.register(ProjectCollaborator)
admin.site.register(ProjectList)
admin.site.register(ProjectPaper)
admin.site.register(Task)
admin.site.register(TaskDependency)
admin.site.register(Note)
admin.site.register(Venue)
admin.site.register(VenueSchedule)
admin.site.register(Conference)
admin.site.register(Journal)
admin.site.register(Submission)
admin.site.register(SubmissionComment)
admin.site.register(FileUpload)
