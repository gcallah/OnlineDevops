UDIR = utils
TDIR = tests
DEVDIR = devops
SITEDIR = mysite
PARTSDIR = participants
TESTSDIR = tests
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
PYTHONFILES += $(shell ls $(DEVDIR)/$(TESTSDIR)/*.py)

FORCE:

validate_html: $(HTMLS)
	./test_html.sh

container:
	docker build -t devops docker

# update our submodules:
submods:
	git submodule update


# tests are not quite ready to include here yet!
prod: $(SRCS) validate_html lint 
	-git commit -a
	git push origin master
	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh'

# by including subs here, we force everyone to update the submod now and again!
staging: submods validate_html lint 
	-git remote add staging nyustaging@ssh.pythonanywhere.com:/home/nyustaging/bare-repos/devops-staging.git
	git push -u staging master

db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

# next come quality control targets:
tests: FORCE
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

gloss: $(GLOSS)

$(GLOSS): $(GLOSS_SRC)
	$(UDIR)/create_gloss.py $(GLOSS_SRC) > $(GLOSS)
	git add $(GLOSS)
	git commit $(GLOSS) -m "Building new glossary template."

datadump:
	python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json
