from django.contrib import admin

# Register your models here.
from .models import Quiz
from .models import Question
from .models import CourseModule

admin.site.register(CourseModule)
admin.site.register(Quiz)
admin.site.register(Question)
