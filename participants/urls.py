from django.urls import path
from django.contrib.auth.views import LoginView, LogoutView

from .views import home

urlpatterns = [
    path('home', home, name='participant_home'),
    path('login',
         LoginView.as_view(template_name='participants_login_form.html'),
         name='participant_login'),
    path('logout',
         LogoutView.as_view(
             template_name='participant_logout_confirmation.html'),
         name='participant_logout')
]
