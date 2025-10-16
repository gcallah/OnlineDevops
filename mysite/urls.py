"""devops URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add an URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add an URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add an URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import django.urls as urls
from django.contrib import admin

urlpatterns = [
    urls.path('admin/', admin.site.urls),
    urls.re_path(r'', urls.include('devops.re_paths')),
    urls.re_path('participants/', urls.include('participants.re_paths')),
    urls.re_path(r'^tinymce/', urls.include('tinymce.re_paths'))
]
