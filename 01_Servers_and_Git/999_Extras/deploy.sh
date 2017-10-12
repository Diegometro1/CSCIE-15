#!/bin/sh

#
# Customize the following for your project/server
#
docRoot="/var/www/html/foobooks"
usernameServer="root@server.ip.address"


# Function to output a line in bold text
dump () {
    echo "\033[1m"$1"\033[0m"
}


# Function to output a line seperator
line () {
    dump "--------------------------------------"
}


# Function to show a `git status` on server and prompts for whether to deploy or not
# This function is invoked when this script is run on your local machine.
welcome () {
    line
    dump "Git status on server for $docRoot:"
    ssh $usernameServer "cd $docRoot; git status"
    line
    dump "Do you want to continue with deployment? (y/n)"

    read -${BASH_VERSION+e}r choice

    case $choice in
        y)
            ssh $usernameServer "$docRoot/bash/deploy.sh"
            ;;
        n)
            dump "Ok, goodbye!";
            exit
            ;;
        *)
            dump "Unknown command";
            ;;
    esac
}


# Function to deploy: pull changes, run composer install
# This function is invoked when this script is invoked on your server
deploy () {
    cd $docRoot;
    line
    dump 'git pull origin master:'
    git pull origin master
    line
    dump 'composer install --no-dev:'
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
