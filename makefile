SDIR = devops
UDIR = utils
MUDIR = myutils
TDIR = tests
MDL = $(SDIR)/models.py
SRCS = $(MDL)
DEVDIR = devops

prod: $(SRCS)
# run tests here before building!
	-git commit -a
	git push origin master
	ssh devopscourse@ssh.pythonanywhere.com 'cd /home/devopscourse/OnlineDevops; /home/devopscourse/OnlineDevops/rebuild.sh'

db: $(MDL)
	python3 manage.py makemigrations
	python3 manage.py migrate
	git add $(DEVDIR)/migrations/*.py
	-git commit $(DEVDIR)/migrations/*.py
	git push origin master

