from django.shortcuts import render
from django.http import request

from .models import Quiz
from .models import Question

site_hdr = "The DevOps Course"

def get_filenm(mod_nm):
    return mod_nm + '.html'

def get_quiz(request, mod_nm):
    questions = Question.objects.filter(module=mod_nm)
    return render(request, get_filenm(mod_nm),
                  {'header': site_hdr, 'questions': questions})

def index(request: request)->object:
    return render(request, 'index.html', {'header': site_hdr})

def about(request: request)->object:
    return render(request, 'about.html', {'header': site_hdr})

def build(request: request)->object:
    return get_quiz(request, 'build')

def cloud(request: request)->object:
    return get_quiz(request, 'cloud')

def comm(request: request)->object:
    return get_quiz(request, 'comm')

def flow(request: request)->object:
    return get_quiz(request, 'flow')

def incr(request: request)->object:
    return get_quiz(request, 'incr')

def infra(request: request)->object:
    return get_quiz(request, 'infra')

def micro(request: request)->object:
    return get_quiz(request, 'micro')

def monit(request: request)->object:
    return get_quiz(request, 'monit')

def secur(request: request)->object:
    return get_quiz(request, 'secur')

def sum(request: request)->object:
    return get_quiz(request, 'sum')

def test(request: request)->object:
    return get_quiz(request, 'test')

def work(request: request)->object:
    return get_quiz(request, 'work')

