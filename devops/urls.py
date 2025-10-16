from django.urls import re_path

from . import views

app_name = 'devops'  # type: str


def view_templ(vname):
    pass
    # we ought to be able to turn all of the code below into a single call


urlpatterns = [
    re_path(r'^$', views.index, name='index'),
    re_path(r'^devops/landing_page/', views.landing_page, name='landing_page'),
    re_path(r'^devops/chapter/(?P<chapter>\D+)/$', views.chapter, name='chapter'),
    re_path(r'^devops/dynamic_about/*$',
        views.dynamic_about, name='dynamic_about'),
    re_path(r'^devops/dynamic_gloss/*$',
        views.dynamic_gloss, name='dynamic_gloss'),
    re_path(r'^devops/about/*$', views.about, name='about'),
    re_path(r'^devops/allquiz/*$', views.allquiz, name='allquiz'),
    re_path(r'^devops/basics/*$', views.basics, name='basics'),
    re_path(r'^devops/gloss/*$', views.gloss, name='gloss'),
    re_path(r'^devops/build/*$', views.build, name='build'),
    re_path(r'^devops/cloud/*$', views.cloud, name='cloud'),
    re_path(r'^devops/comm/*$', views.comm, name='comm'),
    re_path(r'^devops/data/*$', views.data, name='data'),
    re_path(r'^devops/flow/*$', views.flow, name='flow'),
    re_path(r'^devops/grade_quiz/*$', views.grade_quiz, name='grade_quiz'),
    re_path(r'^devops/incr/*$', views.incr, name='incr'),
    re_path(r'^devops/infra/*$', views.infra, name='infra'),
    re_path(r'^devops/micro/*$', views.micro, name='micro'),
    re_path(r'^devops/monit/*$', views.monit, name='monit'),
    re_path(r'^devops/no_quiz/*$', views.no_quiz, name='no_quiz'),
    re_path(r'^devops/parse_search/*$', views.parse_search, name='parse_search'),
    re_path(r'^devops/secur/*$', views.secur, name='secur'),
    re_path(r'^devops/suite/*$', views.suite, name='suite'),
    re_path(r'^devops/sum/*$', views.sum, name='sum'),
    re_path(r'^devops/test/*$', views.test, name='test'),
    re_path(r'^devops/twelve/*$', views.twelve, name='twelve'),
    re_path(r'^devops/cicd/*$', views.cicd, name='cicd'),
    re_path(r'^devops/work/*$', views.work, name='work'),
    re_path(r'^devops/search/*$', views.search, name='search'),
    re_path(r'^devops/teams/*$', views.teams, name='teams'),
]
