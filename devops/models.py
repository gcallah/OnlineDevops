from django.contrib.auth.models import User
from django.db import models
from tinymce.models import HTMLField

QUEST_LEN = 256
ANS_LEN = 128
MODNM_LEN = 16
DEF_PASS = 80.0

QTYPES = (
    ('MCHOICE', 'Multiple choice'),
    ('TF', 'True/False'),
    ('BLANK', 'Fill-in-the-blank'),
    ('ESSAY', 'Essay'),
)


class CourseModule(models.Model):
    """
    This table holds the modules (chapters) of our course.
    The content field should only have the intro material:
        the section contents go in the ModuleSection table.
    """
    module = models.CharField(max_length=MODNM_LEN, unique=True)
    title = models.TextField()
    next_module = models.CharField(max_length=MODNM_LEN)
    content = HTMLField(default='Please enter your contents here!')

    def __str__(self):
        return self.title


class ModuleSection(models.Model):
    """
    This table holds the section content for each module (chapter)
    in our material.
    """
    module = models.ForeignKey(CourseModule,
                               models.SET_NULL, blank=True, null=True)
    title = models.TextField()
    order = models.IntegerField(blank=False, null=False, unique=True)
    content = HTMLField(default='Please enter your contents here!')


class Quiz(models.Model):
    module = models.CharField(max_length=MODNM_LEN, unique=True)
    minpass = models.FloatField(default=DEF_PASS)
    numq = models.IntegerField()
    show_answers = models.BooleanField(default=True)

    def __str__(self):
        return "Quiz for " + self.module


class Question(models.Model):
    module = models.CharField(max_length=MODNM_LEN)
    text = models.CharField(max_length=QUEST_LEN)
    difficulty = models.IntegerField(null=True, blank=True)
    qtype = models.CharField(choices=QTYPES, max_length=10)
    correct = models.CharField(max_length=1)
    answerA = models.CharField(max_length=ANS_LEN, null=True, blank=True)
    answerB = models.CharField(max_length=ANS_LEN, null=True, blank=True)
    answerC = models.CharField(max_length=ANS_LEN, null=True, blank=True)
    answerD = models.CharField(max_length=ANS_LEN, null=True, blank=True)
    answerE = models.CharField(max_length=ANS_LEN, null=True, blank=True)

    def __str__(self):
        return self.text


class Grade(models.Model):
    quiz = models.ForeignKey(Quiz, related_name='quiz',
                             on_delete=models.DO_NOTHING)
    score = models.DecimalField(max_digits=5, decimal_places=2)
    participant = models.ForeignKey(User, related_name='participant',
                                    on_delete=models.DO_NOTHING)
    record_date = models.DateTimeField(auto_now=True)
    quiz_name = models.CharField(max_length=MODNM_LEN, default='work')
