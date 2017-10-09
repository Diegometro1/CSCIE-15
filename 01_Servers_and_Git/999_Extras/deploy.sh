#!/bin/sh

#
# Customize the following for your project/server
#
docRoot="/var/www/html/foobooks"
usernameServer="root@165.227.216.17"


# Outputs a line in bold text
dump () {
    echo "\033[1m"$1"\033[0m"
}


# Outputs a line seperator
line () {
    dump "--------------------------------------"
}


# [Local] Shows git status on server, prompts for whether to deploy or not
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


# [Server]
deploy () {
    cd $docRoot;
    line
    dump 'git pull origin master:'
    git pull origin master
    line
    dump 'composer install:'
    composer install
}


# If this script is run on the server (docRoot exists), it should deploy
if [ -d "$docRoot" ]; then
    echo 'Detected location: Server - Running deployment.'
    deploy
# Otherwise, if this script is run locally, it should prompt for deployment
else
    echo 'Detected location: Local'
    welcome
fi
