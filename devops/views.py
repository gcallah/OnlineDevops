from django.shortcuts import render
from django.http import request

site_hdr = "The DevOps Course"

def index(request: request)->object:
    return render(request, 'index.html', {'header': site_hdr})

def about(request: request)->object:
    return render(request, 'about.html', {'header': site_hdr})

