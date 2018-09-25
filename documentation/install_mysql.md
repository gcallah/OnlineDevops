# Components needed to have Django + MySQL

* Python 3.6
* Django 2.1
* MySQL 5.7
* mysqlclient 1.3 (Python 3 compatible version of MySQL-python)

## Installation

### Linux

#### Download and setup MySQL

* `# sudo apt-get instll mysql-server`
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

_coming soon_

## Configure MySQL local instance

### Logging in and creating users

Log in with root

`$ mysql -u root -p`

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
