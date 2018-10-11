SDIR = devops
UDIR = utils
MUDIR = myutils
TDIR = tests
MDL = $(SDIR)/models.py
SRCS = $(MDL)
DEVDIR = devops
TEMPLDIR = $(DEVDIR)/templates
HTMLS = $(shell ls $(TEMPLDIR)/*.html)

validate_html: $(HTMLS)
	./test_html.sh

container:
	docker build -t devops docker

prod: $(SRCS) validate_html
# run django tests here before committing code!
	-git commit -a
	git push origin master
	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh'

db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

staging:
    git remote | grep staging > /dev/null
    if [ "$?" -eq "0" ]
    then
        echo 'INFO: Staging exists & configured!'
    else
        echo "INFO: Staging does not exist in git remotes, configuring now..."
        git remote add staging nyustaging@ssh.pythonanywhere.com:/home/nyustaging/bare-repos/devops-staging.git
    fi
    echo 'INFO: pushing master to the staging now...'
    git push -u staging master


test:
	$(UDIR)/qexport.py > quizzes/new_test.txt

# to make a quiz for 'mod' set MOD=mod on the command line:
quiz:
	$(UDIR)/qexport.py $(MOD) > quizzes/$(MOD).txt

staging:
	-git remote add staging nyustaging@ssh.pythonanywhere.com:/home/nyustaging/bare-repos/devops-staging.git
	echo 'INFO: pushing master to the staging now...'
	-git push -u staging master
