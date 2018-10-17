UDIR = utils
TDIR = tests
MDL = $(SDIR)/models.py
SRCS = $(MDL)
DEVDIR = devops
TEMPLDIR = $(DEVDIR)/templates
GLOSS = $(TEMPLDIR)/gloss.html
GLOSS_SRC = templates/gloss_terms.txt
HTMLS = $(shell ls $(TEMPLDIR)/*.html)

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
staging: subs
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

# to make a quiz for 'mod' set MOD=mod on the command line:
quiz:
	$(UDIR)/qexport.py $(MOD) > quizzes/$(MOD).txt

gloss: $(GLOSS)

$(GLOSS): $(GLOSS_SRC)
	$(UDIR)/create_gloss.py $(GLOSS_SRC) > $(GLOSS)
