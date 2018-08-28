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
	# here are the tests

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

