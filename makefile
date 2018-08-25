SDIR = quiz
UDIR = utils
MUDIR = myutils
TDIR = tests
SRCS = $(SDIR)/apps.py $(SDIR)/models.py
DEVDIR = devops

prod: $(SRCS)
# run tests here before building!
	-git commit -a
	git push origin master
#	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/mysite; /home/devopscourse/mysite/myutils/prod.sh'

db:
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

