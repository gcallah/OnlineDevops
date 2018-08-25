from django.conf.urls import url

from . import views

app_name = 'devops'  # type: str


urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^devops/about/*$', views.about, name='about'),
]
