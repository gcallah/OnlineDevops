from django.conf.urls import url

from . import views

app_name = 'devops'  # type: str


urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^devops/about/*$', views.about, name='about'),
    url(r'^devops/work/*$', views.work, name='work'),
    url(r'^devops/comm/*$', views.comm, name='comm'),
    url(r'^devops/incr/*$', views.incr, name='incr'),
    url(r'^devops/build/*$', views.build, name='build'),
    url(r'^devops/flow/*$', views.flow, name='flow'),
    url(r'^devops/infra/*$', views.infra, name='infra'),
    url(r'^devops/test/*$', views.test, name='test'),
    url(r'^devops/cloud/*$', views.cloud, name='cloud'),
    url(r'^devops/monit/*$', views.monit, name='monit'),
    url(r'^devops/secur/*$', views.secur, name='secur'),
    url(r'^devops/sum/*$', views.sum, name='sum'),
]
