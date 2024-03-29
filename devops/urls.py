from django.conf.urls import url

from . import views

app_name = 'devops'  # type: str


def view_templ(vname):
    pass
    # we ought to be able to turn all of the code below into a single call


urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^devops/landing_page/', views.landing_page, name='landing_page'),
    url(r'^devops/chapter/(?P<chapter>\D+)/$', views.chapter, name='chapter'),
    url(r'^devops/dynamic_about/*$',
        views.dynamic_about, name='dynamic_about'),
    url(r'^devops/dynamic_gloss/*$',
        views.dynamic_gloss, name='dynamic_gloss'),
    url(r'^devops/about/*$', views.about, name='about'),
    url(r'^devops/allquiz/*$', views.allquiz, name='allquiz'),
    url(r'^devops/basics/*$', views.basics, name='basics'),
    url(r'^devops/gloss/*$', views.gloss, name='gloss'),
    url(r'^devops/build/*$', views.build, name='build'),
    url(r'^devops/cloud/*$', views.cloud, name='cloud'),
    url(r'^devops/comm/*$', views.comm, name='comm'),
    url(r'^devops/data/*$', views.data, name='data'),
    url(r'^devops/flow/*$', views.flow, name='flow'),
    url(r'^devops/grade_quiz/*$', views.grade_quiz, name='grade_quiz'),
    url(r'^devops/incr/*$', views.incr, name='incr'),
    url(r'^devops/infra/*$', views.infra, name='infra'),
    url(r'^devops/micro/*$', views.micro, name='micro'),
    url(r'^devops/monit/*$', views.monit, name='monit'),
    url(r'^devops/no_quiz/*$', views.no_quiz, name='no_quiz'),
    url(r'^devops/parse_search/*$', views.parse_search, name='parse_search'),
    url(r'^devops/secur/*$', views.secur, name='secur'),
    url(r'^devops/suite/*$', views.suite, name='suite'),
    url(r'^devops/sum/*$', views.sum, name='sum'),
    url(r'^devops/test/*$', views.test, name='test'),
    url(r'^devops/twelve/*$', views.twelve, name='twelve'),
    url(r'^devops/cicd/*$', views.cicd, name='cicd'),
    url(r'^devops/work/*$', views.work, name='work'),
    url(r'^devops/search/*$', views.search, name='search'),
    url(r'^devops/teams/*$', views.teams, name='teams'),
]
