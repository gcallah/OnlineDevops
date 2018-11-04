UDIR = utils
TDIR = tests
DEVDIR = devops
SITEDIR = mysite
PARTSDIR = participants
MDL = $(DEVDIR)/models.py
SRCS = $(MDL)
TEMPLDIR = $(DEVDIR)/templates
GLOSS = $(TEMPLDIR)/gloss.html
GLOSS_SRC = templates/gloss_terms.txt
HTMLS = $(shell ls $(TEMPLDIR)/*.html)
PYLINT = flake8
PYLINTFLAGS = 
PYTHONFILES = $(shell ls $(DEVDIR)/*.py)
PYTHONFILES += $(shell ls $(SITEDIR)/*.py)
PYTHONFILES += $(shell ls $(PARTSDIR)/*.py)

validate_html: $(HTMLS)
	./test_html.sh

container:
	docker build -t devops docker

# update our submodules:
submods: 
	git submodule update


prod: $(SRCS) validate_html
# run django tests here before committing code!
	-git commit -a
	git push origin master
	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh'

# by including subs here, we force everyone to update the submod now and again!
staging: submods
	-git remote add staging nyustaging@ssh.pythonanywhere.com:/home/nyustaging/bare-repos/devops-staging.git
	echo 'INFO: pushing master to staging now...'
	git push -u staging master

db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

test:
	$(UDIR)/qexport.py > quizzes/new_test.txt

lint: $(patsubst %.py,%.pylint,$(PYTHONFILES))

%.pylint:
	$(PYLINT) $(PYLINTFLAGS) $*.py

# to make a quiz for 'mod' set MOD=mod on the command line:
quiz:
	$(UDIR)/qexport.py $(MOD) > quizzes/$(MOD).txt

gloss: $(GLOSS)

$(GLOSS): $(GLOSS_SRC)
	$(UDIR)/create_gloss.py $(GLOSS_SRC) > $(GLOSS)
	git add $(GLOSS)
	git commit $(GLOSS) -m "Building new glossary template."
