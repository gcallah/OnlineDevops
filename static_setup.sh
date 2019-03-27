#!/bin/sh

# script to create a static website served by e.g. GitHub pages.
# we need the name of the git repo to clone as $1

add_file()
{
    cp $1/$2 $3/$2
    cd $3; git add $2; cd -
}

echo "we are going to try to make: /html_src "
mkdir html_src
mkdir templates
mkdir tests

utilsdir=utils
if [ -n "$2" ]; then
    utilsdir=$2
fi
echo "utils dir is $utilsdir"

add_file $utilsdir style.css 
add_file "$utilsdir/templates" index.ptml "/html_src"
add_file "$utilsdir/templates" makefile ""
add_file "$utilsdir/templates" head.txt "/templates"
add_file "$utilsdir/templates" menu.txt "/templates"
add_file "$utilsdir/templates" logo.txt "/templates"

cd ; git submodule add https://github.com/gcallah/utils
