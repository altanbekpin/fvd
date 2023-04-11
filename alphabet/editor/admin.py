from django.contrib import admin
from .models import MyOntology, Topic, Question


# Register your models here.
admin.site.register(MyOntology)
admin.site.register(Topic)
admin.site.register(Question)