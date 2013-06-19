#!/bin/sh
#
# Script to rebase all Git submodules against origin and update the master 
# project.

# Ensure "git" binary can be found (e.g. if running from cron)
PATH=$PATH:/usr/bin

git submodule status|while read LINE; do

    MODULE=`echo $LINE|cut -d " " -f 2`

    BASEDIR=`pwd`

    # Rebase submodule against latest code in origin (e.g. GitHub)
    echo -n "$MODULE: "
    cd $MODULE
    git pull --rebase origin

    # Update master project
    cd $BASEDIR
    git add $MODULE
    git commit -m "Updated submodule pointer for $MODULE" -s $MODULE

done

