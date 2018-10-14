from django.conf.urls import url

from . import views

app_name = 'devops'  # type: str

def view_templ(vname):
    pass   # we ought to be able to turn all of the code below into a single
           # call

urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^devops/about/*$', views.about, name='about'),
    url(r'^devops/basics/*$', views.basics, name='basics'),
    url(r'^devops/gloss/*$', views.gloss, name='gloss'),
    url(r'^devops/teams/*$', views.teams, name='teams'),
    url(r'^devops/build/*$', views.build, name='build'),
    url(r'^devops/cloud/*$', views.cloud, name='cloud'),
    url(r'^devops/comm/*$', views.comm, name='comm'),
    url(r'^devops/flow/*$', views.flow, name='flow'),
    url(r'^devops/incr/*$', views.incr, name='incr'),
    url(r'^devops/infra/*$', views.infra, name='infra'),
    url(r'^devops/micro/*$', views.micro, name='micro'),
    url(r'^devops/monit/*$', views.monit, name='monit'),
    url(r'^devops/no_quiz/*$', views.no_quiz, name='no_quiz'),
    url(r'^devops/secur/*$', views.secur, name='secur'),
    url(r'^devops/sum/*$', views.sum, name='sum'),
    url(r'^devops/test/*$', views.test, name='test'),
    url(r'^devops/work/*$', views.work, name='work'),
    url(r'^devops/grade_quiz/*$', views.grade_quiz, name='grade_quiz'),
]
