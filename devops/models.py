from django.contrib.auth.models import User
from django.db import models

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
    module = models.CharField(max_length=MODNM_LEN)
    title = models.TextField()
    next_module = models.CharField(max_length=MODNM_LEN)

class Quiz(models.Model):
    module = models.CharField(max_length=MODNM_LEN)
    minpass = models.FloatField(default=DEF_PASS)
    numq = models.IntegerField()

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
