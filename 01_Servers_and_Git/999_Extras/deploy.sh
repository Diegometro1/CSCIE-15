#!/bin/sh

#
# Customize the following for your project/server
#
docRoot="/var/www/html/foobooks"
usernameServer="root@server.ip.address"


# Helper function to output a line seperator
line () {
    echo "--------------------------------------"
}


# Function to show a `git status` on server and prompts for whether to deploy or not
# This function is invoked when this script is run on your local machine.
welcome () {
    line
    echo "Git status on server for $docRoot:"
    ssh $usernameServer "cd $docRoot; git status"
    line
    echo "Do you want to continue with deployment? (y/n)"

    read -${BASH_VERSION+e}r choice

    case $choice in
        y)
            ssh $usernameServer "$docRoot/bash/deploy.sh"
            ;;
        n)
            echo "Ok, goodbye!";
            exit
            ;;
        *)
            echo "Unknown command";
            ;;
    esac
}


# Function to deploy: pull changes, run composer install
# This function is invoked when this script is invoked on your server
deploy () {
    cd $docRoot;
    line
    echo 'git pull origin master:'
    git pull origin master
    line
    echo 'composer install --no-dev:'
    composer install --no-dev
}


# If this script is run on the server (docRoot exists), it should deploy
if [ -d "$docRoot" ]; then
    echo 'Detected location: Server - Running deployment.'
    deploy
# Otherwise, if this script is run locally,
# it should invoke `welcome` to determine whether to deploy
else
    echo 'Detected location: Local'
    welcome
fi
