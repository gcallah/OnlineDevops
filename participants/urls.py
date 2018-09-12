from django.conf.urls import url

from .views import home

urlpatterns = [
    url('home', home, name='participant_home')
]