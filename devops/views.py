from django.shortcuts import render
from django.http import request

site_hdr = "The DevOps Course"

def index(request: request)->object:
    return render(request, 'index.html', {'header': site_hdr})

def about(request: request)->object:
    return render(request, 'about.html', {'header': site_hdr})

def work(request: request)->object:
    return render(request, 'work.html', {'header': site_hdr})

def comm(request: request)->object:
    return render(request, 'comm.html', {'header': site_hdr})

def incr(request: request)->object:
    return render(request, 'incr.html', {'header': site_hdr})

def build(request: request)->object:
    return render(request, 'build.html', {'header': site_hdr})

def flow(request: request)->object:
    return render(request, 'flow.html', {'header': site_hdr})

def infra(request: request)->object:
    return render(request, 'infra.html', {'header': site_hdr})

def monit(request: request)->object:
    return render(request, 'monit.html', {'header': site_hdr})

def cloud(request: request)->object:
    return render(request, 'cloud.html', {'header': site_hdr})

def secur(request: request)->object:
    return render(request, 'secur.html', {'header': site_hdr})

def test(request: request)->object:
    return render(request, 'test.html', {'header': site_hdr})

def sum(request: request)->object:
    return render(request, 'sum.html', {'header': site_hdr})

