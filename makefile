UDIR = utils
TDIR = tests
DEVDIR = devops
SITEDIR = mysite
PARTSDIR = participants
TEST_DIR = tests
MDL = $(DEVDIR)/models.py
SRCS = $(MDL)
DJANGO_TEMPLDIR = $(DEVDIR)/templates
GLOSS = $(DJANGO_TEMPLDIR)/gloss.html
OUR_TEMPLDIR = templates
GLOSS_SRC = $(OUR_TEMPLDIR)/gloss_terms.txt
HTMLS = $(shell ls $(DJANGO_TEMPLDIR)/*.html)
PYLINT = flake8
PYLINTFLAGS =
PYTHONFILES = $(shell ls $(DEVDIR)/*.py)
PYTHONFILES += $(shell ls $(SITEDIR)/*.py)
PYTHONFILES += $(shell ls $(PARTSDIR)/*.py)
PYTHONFILES += $(shell ls $(DEVDIR)/$(TEST_DIR)/*.py)

FORCE:

container:
	docker build -t devops docker

# update our submodules:
submods:
	git submodule update


db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

# build our glossary
gloss: $(GLOSS)

$(GLOSS): $(GLOSS_SRC)
# Monjur run your program here; write output to $(OUR_TEMPLDIR)
	$(UDIR)/create_gloss.py $(GLOSS_SRC) > $(GLOSS)
	git add $(GLOSS)
	git commit $(GLOSS) -m "Building new glossary template."

datadump:
	python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json

# next come quality control targets:
html_tests: $(HTMLS)
	$(TEST_DIR)/html_tests.sh

django_tests: FORCE
	coverage run manage.py test

lint: $(patsubst %.py,%.pylint,$(PYTHONFILES))

%.pylint:
	$(PYLINT) $(PYLINTFLAGS) $*.py

# ways to extract questions from db for use in LMS:
# to make a quiz for 'mod' set MOD=mod on the command line:
quiz:
	$(UDIR)/qexport.py $(MOD) > quizzes/$(MOD).txt

# this extracts ALL questions for, say, the final
final_test:
	$(UDIR)/qexport.py > quizzes/new_test.txt

# tests are not quite ready to include here yet!
prod: $(SRCS) html_tests lint 
	-git commit -a
	git push origin master
	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh'

staging: html_tests lint 
	-git remote add staging nyustaging@ssh.pythonanywhere.com:/home/nyustaging/bare-repos/devops-staging.git
	git push -u staging master
