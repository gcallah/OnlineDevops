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
    mod_nm = 'build'
    return get_quiz(request, mod_nm)

def cloud(request: request)->object:
    mod_nm = 'cloud'
    return get_quiz(request, mod_nm)

def comm(request: request)->object:
    mod_nm = 'comm'
    return get_quiz(request, mod_nm)

def flow(request: request)->object:
    mod_nm = 'flow'
    return get_quiz(request, mod_nm)

def incr(request: request)->object:
    mod_nm = 'incr'
    return get_quiz(request, mod_nm)

def infra(request: request)->object:
    return render(request, 'infra.html',
        {'header': site_hdr})

def micro(request: request)->object:
    return render(request, 'micro.html',
        {'header': site_hdr})

def monit(request: request)->object:
    return render(request, 'monit.html',
        {'header': site_hdr})

def secur(request: request)->object:
    return render(request, 'secur.html',
        {'header': site_hdr})

def sum(request: request)->object:
    return render(request, 'sum.html',
        {'header': site_hdr})

def test(request: request)->object:
    return render(request, 'test.html',
        {'header': site_hdr})

def work(request: request)->object:
    return render(request, 'work.html',
        {'header': site_hdr})

