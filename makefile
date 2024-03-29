UDIR = utils
TDIR = tests
DEVDIR = devops
MIGRDIR = $(DEVDIR)/migrations
SITEDIR = mysite
PARTSDIR = participants
TEST_DIR = tests
MDL = $(DEVDIR)/models.py
SRCS = $(MDL)
DJANGO_TEMPLDIR = $(DEVDIR)/templates
OUR_TEMPLDIR = templates
GLOSS = $(DJANGO_TEMPLDIR)/gloss.html
GLOSS_SRC = $(OUR_TEMPLDIR)/gloss_terms.txt
HTMLS = $(shell ls $(DJANGO_TEMPLDIR)/*.html)
PYLINT = flake8
PYLINTFLAGS = --max-returns-amount=5
PYTHONFILES = $(shell ls $(DEVDIR)/*.py)
PYTHONFILES += $(shell ls $(SITEDIR)/*.py)
PYTHONFILES += $(shell ls $(PARTSDIR)/*.py)
PYTHONFILES += $(shell ls $(DEVDIR)/$(TEST_DIR)/*.py)
DOCKER_DIR = docker
REQ_DIR = .
REPO = OnlineDevops
LOWER_REPO = `echo $(REPO) | tr A-Z a-z`
DH_ACCOUNT = gcallah
FORMAT = brightspace

FORCE:

dev_container: $(DOCKER_DIR)/Dockerfile $(DOCKER_DIR)/requirements.txt $(DOCKER_DIR)/requirements-dev.txt
	docker build -t $(DH_ACCOUNT)/$(LOWER_REPO)-dev $(DOCKER_DIR) --build-arg repo=$(LOWER_REPO)
	docker push $(DH_ACCOUNT)/$(LOWER_REPO)-dev:latest

prod_container: $(DOCKER_DIR)/Deployable $(DOCKER_DIR)/requirements.txt
	docker build -t $(DH_ACCOUNT)/$(REPO) $(DOCKER_DIR) --no-cache --build-arg repo=$(REPO) -f $(DOCKER_DIR)/Deployable

dev_env:
	pip3 install -r $(REQ_DIR)/requirements-dev.txt

# update our submodules:
submods:
	git submodule foreach 'git pull origin master'


db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(MIGRDIR)/*.py
	-git commit $(MIGRDIR)/*.py
	git push origin master

# build our glossary
gloss: $(GLOSS)

$(GLOSS): $(GLOSS_SRC)
	# first create glossary:
	$(UDIR)/create_gloss.py $(GLOSS_SRC) > $(GLOSS)
	git add $(GLOSS)
	-git commit $(GLOSS) -m "Building new glossary template."
	# now make include files:
	$(UDIR)/gloss_links.py $(GLOSS_SRC) $(DJANGO_TEMPLDIR) --lf $(HTMLS)
	git add $(DJANGO_TEMPLDIR)/*.txt
	-git commit $(DJANGO_TEMPLDIR)/*.txt -m "Building new glossary includes."

datadump:
	python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json

# next come quality control targets:
html_tests: $(HTMLS)
	$(TEST_DIR)/html_tests.sh

django_tests: FORCE
	# ./pytests/sh
	coverage run manage.py test

lint: $(patsubst %.py,%.pylint,$(PYTHONFILES))

%.pylint:
	$(PYLINT) $(PYLINTFLAGS) $*.py

tests: html_tests django_tests lint

# ways to extract questions from db for use in LMS:
# to make a quiz for 'mod' set MOD=mod on the command line:
quiz:
	$(UDIR)/qexport.py $(MOD) $(FORMAT) > quizzes/$(MOD).csv

# this extracts ALL questions for, say, the final
final_test:
	$(UDIR)/qexport.py > quizzes/new_test.txt

prod: $(SRCS) tests db
	-git commit -a
	git push origin master
