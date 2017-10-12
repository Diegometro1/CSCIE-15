# Deployment script
Note: Setting up a deployment script for your projects in this course is __optional__. If you don't wish to dig into shell scripting, you can continue to deploy using the manual procedures covered in Weeks 1 and 2.

## Preface
When we're ready to deploy changes to our production servers, we start by locally adding and committing all files we wish to deploy, for example:

```bash
$ git add --all
$ git commit -m "Added form validation"
```

Then, we run the following 5 commands to deploy these changes on our production servers.

1. Push changes to our master repository in Github:
```bash
$ git push origin master
```

2. SSH into the production server:
```bash
ssh root@ip.address
```

3. Move into the project directory (Laravel project `foobooks` used here as an example):
```bash
cd /var/www/html/foobooks
```

4. Pull the latest changes:
```bash
git pull origin master
```

5. Update packages (if a Laravel-based project):
```bash
composer install --no-dev
```

Running these 5 commands can be streamlined into a single command via a __deployment script__.

A deployment script is a [shell script](https://www.panix.com/~elflord/unix/bash-tute.html) (i.e. a command line script) that lets you group together a series of commands you want to run when deploying changes to your application on production.

We can streamline the process even further by creating a [git alias](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) to git push and invoke your deployment script.


## Setup
### Step 1) Local setup
Copy the contents [of this file](https://raw.githubusercontent.com/susanBuck/dwa15-fall2017/master/01_Servers_and_Git/999_Extras/deploy.sh) and save it locally in your project as `bash/deploy.sh` (you'll need to create the subdirectory `bash`).

At the top of this file are two configuration variables you need to customize:

```
docRoot="/var/www/html/foobooks"
usernameServer="root@server.ip.address"
```

Change `docRoot` to the document root for the applicable project on your production server.

Change `usernameServer` to match the combination you typically use to SSH into your server.

(Do not add any spaces before/after the equal sign)

While you have this file open, skim through its contents to understand what it does. The file is written using a shell scripting language, but aside from syntax differences, the basic flow should be mostly understandable.

Next, give the deploy script executable [permissions](https://github.com/susanBuck/dwa15-fall2017/blob/master/00_Command_Line/99_Extras/Permissions.md) (`+x`) on your local machine:
```
$ chmod +x bash/deploy.sh
```

Add, commit, and push this new file:
```
$ git add bash/deploy.sh
$ git commit -m "Added deploy script"
$ git push origin master
```


### Step 2) Server setup
SSH into your server to pull the latest changes (including this new script).

```xml
$ ssh root@server.ip.address
$ cd /var/www/html/foobooks
$ git pull origin master
```

With the deploy script now on your server, give it executable [permissions](https://github.com/susanBuck/dwa15-fall2017/blob/master/00_Command_Line/99_Extras/Permissions.md) (`+x`)

```xml
$ chmod +x /var/www/html/foobooks/bash/deploy.sh
```


### Step 3) Setup alias locally
Next, we want to set up a git alias that will push any commits *and* invoke your deploy script.

This is done by editing `.git/config` and adding an alias to the bottom like so:
```
[alias]
    pd = !git push origin master && bash/deploy.sh
```

After you save your changes to `.git/config` test out your new alias by running the following:
```
$ git pd
```

You should see a prompt like the following, assuming you have no changed files on your production server. Note that you're prompted to continue with deployment:

```xml
Everything up-to-date
Detected location: Local
--------------------------------------
Git status on server for /var/www/html/foobooks:
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
--------------------------------------
Do you want to continue with deployment? (y/n)
```

If you do have changed files on your server you'll see them listed, and __you may want to abort deployment (by typing `n`) so that you can resolve any potential conflicts before they occur.__

If you continue with deployment (by typing `y`), you'll see something like this, which shows the output of a `git pull origin master` followed by a `composer install`:

```xml
Do you want to continue with deployment? (y/n)
y
Detected location: Server - Running deployment.
--------------------------------------
git pull origin master:
From github.com:susanBuck/foobooks
 * branch            master     -> FETCH_HEAD
Already up-to-date.
--------------------------------------
composer install:
Do not run Composer as root/super user! See https://getcomposer.org/root for details
Loading composer repositories with package information
Installing dependencies (including require-dev) from lock file
Nothing to install or update
Generating optimized autoload files
> Illuminate\Foundation\ComposerScripts::postAutoloadDump
> @php artisan package:discover
Discovered Package: fideloper/proxy
Discovered Package: laravel/tinker
Package manifest generated successfully.
```


## Common problems and tips

### Problem: deploy.sh: Permission denied
If you receive the following message when trying to run your deploy script...
```bash
-bash: ./bash/deploy.sh: Permission denied#
```

...make sure you gave the script executable permissions (on both your local *and* server copy):

```bash
chmod +x bash/deploy.sh
```

When running `ls -l` your permissions for the deployment script should be set to `-rw-r--r--`. Example:

```xml
$ cd bash
$ ls -l
total 8
-rw-r--r--   1 Susan  admin  1314 Oct  9 16:36 deploy.sh
```

### Adding additional deployment commands
`git pull origin master` and `composer install` are the two main deployment commands we need to run on our servers, but deployment scripts can be customized to run more commands based on your application/team needs.

For example, Laravel has an artisan command to combine all configuration files into one flat file, making the loading of configurations quicker. It'd be logical to run this command with each deployment to regenerate that flat file, so the following command might be added to the `deploy` function in the `deploy.sh` script:

```bash
php artisan config:cache
```


## More about shell scripting
Shell scripts use their own syntax language. Looking at the provided `deploy.sh` you can see the syntax for basic programming paradigms such as variables, functions, and switch statements. [You can learn more about the basics of writing shell scripts here...](https://www.panix.com/~elflord/unix/bash-tute.html)
