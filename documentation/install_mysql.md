#### Table of Contents

1. [Automated Installation](#automated-installation)
   * [Linux](#docker-linux)
   * [Mac OS X](#docker-mac-os-x)
   * [Windows](#docker-windows)
   * [Docker Compose](#docker-compose)
1. [Manual Installation](#manual-installation)
   * [Components](#components-needed-to-have-django-and-mysql)
   * [Linux](#linux)
   * [Mac OS X](#mac-os-x)
   * [Windows](#windows)
1. [Configure MySQL local instance](#configure-mysql-local-instance)
   * [Logging in and creating users](#logging-in-and-creating-users)
   * [Creating the database](#creating-the-database)
   * [Migrate existing data and change django app settings to MySQL](#migrate-existing-data-and-change-django-app-settings-to-mysql)
1. [Validation](#validation)

## Automated Installation

The automated install is the preferred method to install and use MySQL for the django application's database. The automated install leverages **Docker** to run both the django and mysql applications within containers.

You will need to download and install docker Community Edition on your machine. If you're on an older mac/windows system, you will need to install docker toolbox instead of 'Docker for Mac/Windows'. If you're on linux, you can use your package manager to install Docker.

### Docker Linux

Instructions are for Ubuntu, check the official docs for any differences on your distro

* Setup the repository
  * `$ sudo apt-get update`
  * `$ sudo apt-get install apt-transport-https ca-certificates curl software-properties-common`
  * `$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
  * `$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
* Install Docker CE
  * `$ sudo apt-get update`
  * `$ sudo apt-get install docker-ce`
* Install Docker Compose
  * `sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose`
  * `sudo chmod +x /usr/local/bin/docker-compose`

### Docker Mac OS X

* System Requirements
  * Mac hardware must be a 2010 or newer model, with Intel’s hardware support for memory management unit (MMU) virtualization, including Extended Page Tables (EPT) and Unrestricted Mode. You can check to see if your machine has this support by running the following command in a terminal: sysctl kern.hv_support
  * macOS El Capitan 10.11 and newer macOS releases are supported. We recommend upgrading to the latest version of macOS.
  * At least 4GB of RAM
  * VirtualBox prior to version 4.3.30 must NOT be installed (it is incompatible with Docker for Mac). If you have a newer version of VirtualBox installed, it’s fine.
  
If your Mac meets the system requirements, download and install [Docker for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac). If your system does not meet the requirements, download and install [Docker Toolbox](https://docs.docker.com/toolbox/overview/)

Both **Docker for Mac** and **Docker Toolbox** come with **Docker Compose**, so whichever you choose to install will work fine. Double click on the installer and accept the defaults when/if prompted.

### Docker Windows

* System Requirements
  * Windows 10 64bit: Pro, Enterprise or Education (1607 Anniversary Update, Build 14393 or later).
  * Virtualization is enabled in BIOS. Typically, virtualization is enabled by default. This is different from having Hyper-V enabled. For more detail see Virtualization must be enabled in Troubleshooting.
  * CPU SLAT-capable feature.
  * At least 4GB of RAM.

If your computer meets the system requirements, download and install [Docker for Windows](https://store.docker.com/editions/community/docker-ce-desktop-windows). If your system does not meet the requirements, download and install [Docker Toolbox](https://docs.docker.com/toolbox/overview/)

Both **Docker for Windows** and **Docker Toolbox** come with **Docker Compose**, so whichever you choose to install will work fine. Double click on the installer and accept the defaults when/if prompted.

### Docker Compose

[Official documentation](https://docs.docker.com/compose/overview/)

Docker Compose is a tool to facilicate defining and running multiple containers. A YAML file (by convention docker-compose.yml) is used to define the application(s) services. The two YAML files that are needed are _docker-compose.yml_ and _django-container.yml_. To install MySQL and connect the django app, execute `$ docker-compose up` from the command line.

Compose will look at the docker-compose file, build the images, and create/start the containers. The entire process should take a few minutes if building the images and less than a minute if the images are already built (depending on your system specs).

The django application and MySQL will both be running within a container now. Therefore if you want to view/edit something pertaining to the application in real time, you would need to go into the container where the application is running. At the time of this writing, the application source code for the local development server is copied into the container when it's created, so changing source code files on your host machine will not be immediately reflected in the browser. To see your changes, stop Compose `$docker-compose down` and bring it up again `$docker-compose up` (you may need to rebulid your image(s) `$docker-compose up --build`).

#### Basic Docker commands

* `docker info` - information about your docker configuration.
* `docker images` - list images.
* `docker ps` - list running containers. use the `docker ps -a` option to show all containers (including stopped).
* `docker-compose up` - bring up the application service(s).
  * `docker-compose bulid` - just build the images from compose.
  * `docker-compose up --build` - bring up the application service(s) and re-build the images.
  * `docker-compose down` - bring down the application service(s).
* `docker rm <container>` - remove one or more containers.
* `docker rmi <image>` - remove one or more images.
* `docker exec -it <appname> /bin/bash` - enter the container interactively with bash shell.

## Manual Installation

If you would like to go with a manual installation of MySQL that isn't running in a container or perhaps you already have MySQL installed and want to connect the django application to it, this section is for you.

### Components needed to have Django and MySQL

* [Python 3.6](https://www.python.org/downloads/release/python-360/)
* [Django 2.1](https://www.djangoproject.com/download/)
* [MySQL 5.7](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
* [mysqlclient 1.3 (Python 3 compatible version of MySQL-python)](https://pypi.org/project/mysqlclient/)

### Linux

#### Download and setup MySQL

* `$ sudo apt-get install mysql-server`
* `$ sudo mysql_secure_installation`

Check mysql instance is working

* `$ systemctl status mysql.service`

#### Install mysqlclient which adds python 3 support and bug fixes

Install python and mysql development headers and libraries

* `$ sudo apt-get install python-dev default-libmysqlclient-dev`

Since we are using python 3, we need to install python3-dev

* `$ sudo apt-get install python3-dev`

* `$ pip3 install mysqlclient`

#### Install django-mysql which helps use some mysql/mariadb specific features in django

* `$ pip3 install django-mysql`
* add django_mysql to installed apps (/mysite/settings.py)

```python
INSTALLED_APPS = (
    ...
    'django_mysql',
    ...
)
```
* check Django + MySQL config is good to go
  * `$ python3 manage.py check`

### Mac OS X

#### Download and run dmg

[MySql Installer for macOS](https://dev.mysql.com/downloads/installer/)

Double click the MySQL installer package and follow the prompts within the installation wizard.

[Official documentation](https://dev.mysql.com/doc/refman/8.0/en/osx-installation-pkg.html)

### Windows

#### Download and run msi

[MySql Installer for windows](https://dev.mysql.com/downloads/installer/)

Choose whichever setup type you'd like. If unsure, `Developer default` is satisfactory, but any option that includes mysql server will work. if the option you pick does not include [Connector/Python](https://dev.mysql.com/downloads/connector/python/) you can download and install that separately

Accept the defaults within the installation wizard with the exception of the `Accounts and Roles` section. In `Accounts and Roles` set a root password and create a user account within that same screen if you'd like.

By default, the windows installer doesn't add mysql.exe to PATH. Open up PowerShell (or add it from the system properties GUI) and run the following command (mysql.exe may be located somewhere else in your filesystem. change the path directory as appropriate)
* `> [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\MySQL\MySQL Server 8.0\bin", [EnvironmentVariableTarget]::Machine)`

#### Windows installation issues

On windows, you may have issues when installing mysqlclient from pip
* `> python -m pip install mysqlclient`

Try specifying the prior version
* `> python -m pip install mysqlclient==1.3.12`

If that did not work, try installing mysqlclient from [source](https://github.com/PyMySQL/mysqlclient-python/archive/master.zip). You may also need to download a specific connector (6.0.2) as the source package is explictly looking for that. After downloading `Connector 6.0.2` update site.cfg with the appropriate path e.g. `connector = C:\Program Files (x86)\MySQL\MySQL Connector C 6.0.2`

On windows, you may get the error `error: Microsoft Visual C++ 14.0 is required. Get it with "Microsoft Visual C++ Build Tools": http://landinghub.visualstudio.com/visual-cpp-build-tools`
* download the [visual C++ build tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/) and install. Even though the error is complaining about visual c++ 2014, everything works fine with newer versions
* after rebooting, try installing mysqlclient from source again

## Configure MySQL local instance

### Logging in and creating users

Log in with root

* `$ mysql -u root -p`

If that fails, sudo su and you should be able to use mysql

* `$ sudo su`
* `# mysql <command>`

Create a user if desired

**On windows, the latest MySQL installer version uses caching_sha2_password as default authentication plugin causing compatibility issues**
> when creating a user on windows with the newer MySQL version specify the previous authentication plugin instead  
> `mysql> CREATE USER '<name>'@'localhost' IDENTIFIED WITH mysql_native_password BY '<passwd>';`

If not using the newer version of MySQL or the newer authentication plugin was not selected upon installation,

> `mysql> CREATE USER '<name>'@'localhost' IDENTIFIED BY '<passwd>';`
* `mysql> GRANT ALL PRIVILEGES ON *.* TO '<name>'@'localhost';`
* `mysql> FLUSH PRIVILEGES;`

If you get an **ERROR 1396** message, you can use this work around to get around the known bug

* drop user, flush, and try to create again
  * `mysql> DROP USER '<name>'@'localhost';`
  * `mysql> FLUSH PRIVILEGES;`
 
 ### Creating the database
 
 From the msql prompt, you can see the database(s) managed by the server
 
* `mysql> show databases;`
 
 You can create as many databases as you want in your local instance, but there are 4 DBs that the class will be using (one for each environment)
 
* devops_course
* test_devops_course
* staging_devops
* test_staging_devops

Create the database (run commands as root, or another user that you gave admin permissions to)

> `mysql> CREATE DATABASE <dbname>;`  
> `mysql> GRANT ALL PRIVILEGES ON <dbname>.* TO '<username>':'localhost';`  
> `mysql> FLUSH PRIVILEGES;`  
> `mysql> QUIT`

### Migrate existing data and change django app settings to MySQL

Create a data dump to be loaded later
* `$ python manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json`

#### settings.py

Change **DATABASES** in *mysite/settings.py*

FROM:
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```
TO:
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '<dbname>',
        'USER': '<username>',
        'PASSWORD': '<userpass>',
        'HOST': '127.0.0.1', 
        'PORT': '',
    }
}
```

The line `'default': {` is the DB that will be defaulted to when none is specified. To add multiple DBs just change that line, the rest could stay the same i.e. `'test_devops_course': {`. 

For your local dev instance, the host and port lines are optional. You should also be using environment variables to pass data (password specifically) instead.

```python
    'default': {
        'ENGINE': os.environ.get('ENGINE', 'django.db.backends.sqlite3'),
        'NAME': os.environ.get('dbname'),
        'USER': os.environ.get('mysqlusername'),
        'PASSWORD': os.environ.get('mysql_pass'),
        'HOST': os.environ.get('host')
    },
```

#### migrations

Apply any migrations to the new MySQL database(s)

> `$ python3 manage.py makemigrations`  
> `$ python3 manage.py migrate --run-syncdb`  
> `$ python3 manage.py loaddata datadump.json`

## Validation

At this point, the transition to MySQL from sqlite3 should be complete. You can verify everything is working by starting you dev server and browsing through the UI. You can also check the DB and it's contents from the mysql prompt

Show databases
* `mysql> show databases;`

Select a DB and show the tables
* `mysql> use <dataname>;`
* `mysql> show tables;`

View table structure
* `mysql> describe <tablename>;`

View data within table
* `mysql> select * from <tablename>;`
