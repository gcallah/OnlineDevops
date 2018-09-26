# Components needed to have Django + MySQL

* [Python 3.6](https://www.python.org/downloads/release/python-360/)
* [Django 2.1](https://www.djangoproject.com/download/)
* [MySQL 5.7](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
* [mysqlclient 1.3 (Python 3 compatible version of MySQL-python)](https://pypi.org/project/mysqlclient/)

#### Table of Contents

1. [Installation](#installation)
   * [Linux](#linux)
   * [Mac OS X](#mac-os-x)
   * [Windows](#windows)
1. [Configure MySQL local instance](#configure-mysql-local-instance)
   * [Logging in and creating users](#logging-in-and-creating-users)
   * [Creating the database](#creating-the-database)
   * [Migrate existing data and change django app settings to MySQL](#migrate-existing-data-and-change-django-app-settings-to-mysql)
1. [Validation](#validation)

## Installation

### Linux

#### Download and setup MySQL

* `# sudo apt-get install mysql-server`
* `# sudo mysql_secure_installation`

Check mysql instance is working

* `$ systemctl status mysql.service`

#### Install mysqlclient which adds python 3 support and bug fixes

Install python and mysql development headers and libraries

* `# sudo apt-get install python-dev default-libmysqlclient-dev`

Since we are using python 3, we need to install python3-dev

* `# sudo apt-get install python3-dev`

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

_coming soon_

### Windows

#### Download and run msi

[MySql Installer for windows](https://dev.mysql.com/downloads/installer/)

Choose whichever setup type you'd like. If unsure, `Developer default` is satisfactory, but any option that includes mysql server will work. if the option you pick does not include [Connector/Python](https://dev.mysql.com/downloads/connector/python/) you can download and install that separately

Accept the defaults within the installation wizard with the exception of the `Accounts and Roles` section. In `Accounts and Roles` set a root password and create a user account within that same screen if you'd like.

By default, the windows installer doesn't add mysql.exe to PATH. Open up PowerShell (or add it from the system properties GUI) and run the following command (mysql.exe may be located somewhere else in your filesystem. change the path directory as appropriate)
* `PS Z:\> [Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\MySQL\MySQL Server 8.0\bin", [EnvironmentVariableTarget]::Machine)`

#### Windows installation issues

On windows, you may have issues when installing mysqlclient from pip
* `> python -m pip install mysqlclient`
* Thus, try installing mysqlclient from [source](https://github.com/PyMySQL/mysqlclient-python/archive/master.zip)

On windows, you may get an error `error: Microsoft Visual C++ 14.0 is required. Get it with "Microsoft Visual C++ Build Tools": http://landinghub.visualstudio.com/visual-cpp-build-tools`
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

* `mysql> CREATE USER '<name>'@'localhost' IDENTIFIED BY '<passwd>';`
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
* `$ python3 manage.py dumpdata --natural-foreign --natural-primary -e contenttypes -e auth.Permission --indent 4 > datadump.json`

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
