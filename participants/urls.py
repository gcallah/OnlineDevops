from django.conf.urls import url
from django.contrib.auth.views import LoginView, LogoutView

from .views import home

urlpatterns = [
    url('home', home, name='participant_home'),
    url('login',
        LoginView.as_view(template_name='participants_login_form.html'),
        name='participant_login'),
    url('logout',
        LogoutView.as_view(
            template_name='participant_logout_confirmation.html'),
        name='participant_logout')
]
