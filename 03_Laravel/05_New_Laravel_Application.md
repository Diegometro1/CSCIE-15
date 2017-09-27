## Preflight check

The Laravel framework has these system requirements:

+ PHP >= 7.0.0
+ OpenSSL PHP Extension
+ PDO PHP Extension
+ Mbstring PHP Extension
+ Tokenizer PHP Extension
+ XML PHP Extension

If you've followed our lead and set your PHP executable to be the same as the PHP that ships with MAMP/XAMPP, your local server should meet all these requirements.


## Create a new Laravel applications
We're going to create a new Laravel application using Composer.

Change directories into your local *Document Root* where your new app will live.

Mac:
```bash
$ cd /Applications/MAMP/htdocs
```

Windows:
```bash
$ cd c:\xampp\htdocs
```

Next, use the following `composer` command to generate a new Laravel project.

Swap in `foobooks` with whatever you want your application name to be.

Note: This command may take a minute or few to complete as it downloads all the necessary Laravel files.

```bash
$ composer create-project laravel/laravel foobooks "5.5.*" --prefer-dist
```

If you see warnings or errors after running this command, scroll down to see if your issue is listed in the __Troubleshooting__ section.

When Composer is done working, move into the newly created project directory:

```
$ cd foobooks
```

Once in this directory, run a list command to see all the Laravel related files.

<img src='http://making-the-internet.s3.amazonaws.com/laravel-fresh-install@2x.png' style='max-width:732px; width:100%' alt='Laravel fresh install'>


## Permissions
At this point in the installation procedure, some Laravel tutorials would have you run specific commands to make the `storage` and `bootstrap/cache` directories writable.

When using Laravel, the Apache web server needs *write* access for the `storage` and `bootstrap/cache` directories because Laravel will write data to these directories. For example, errors will be written to `storage/logs/laravel.log`, and cached configurations to speed up your app will be written to `bootstrap/cache`.

But for __Windows/XAMPP users__, you shouldn't need to adjust permissions because Apache already has all the permissions it needs since it runs under Window's LocalSystem account  which has extensive read/write access to local paths.

Likewise, most __Mac/MAMP users__ shouldn't need to adjust any permissions because MAMP's Apache is running as the user who launched it, i.e. you, and as owner of all the files and directories in your project, you already have write access.

The only instance where this might not work is if you're using a different local server setup that does *not* have the correct permission configuration. If that were the cause, you'd want to configure `storage` and `bootstrap/cache` to be writable by your web server.

We'll talk specifically about setting permissions on DigitalOcean when we get to deployment in the next note set.


## Namespacing
As we learned when exploring the fundamentals of PHP, namespacing is a programming technique that helps you avoid name conflicts between classes used in an application.

If you don't explicitly set a namespace for your Laravel application, it will default to `App`.

__In the interest of making lecture examples more generic, we're *not* going to rename the Foobooks namespace; instead we'll and leave it as the default `App`.__

However, if you we did want to change the application's namespace, the command would look like this:
```bash
$ php artisan app:name Foobooks
```

If you're a less experienced programmer, I do **not** recommend changing your application's namespace from the default for applications you build in this course.

Reasons:
1. There's low risk that you'll face a naming conflict for applications you build in this course.
2. We repeatedly see students face issues with namespacing because they forget they changed their app namespace and subsequently forget to update provided example code to reflect this.


## Point local server to your new app
The bare bones initial setup for your app is complete, and you should be ready to view it in the browser.

First, though, you'll need to point your localhost's *Document Root* to the `public/` directory within your new app.

Your document root paths should look like this:

Mac:
```xml
/applications/MAMP/htdocs/foobooks/public
```

Windows:
```xml
c:\xampp\htdocs\foobooks\public
```

In MAMP you can change the *Document Root* via the Apache settings:

<img src='http://making-the-internet.s3.amazonaws.com/laravel-app-setup-document-root@2x.png' class='' style='max-width:300px; width:100%'>

In XAMPP you'll change the *Document Root* via Apache's config file, `httpd.conf`:

<img src='http://making-the-internet.s3.amazonaws.com/laravel-xamp-document-root@2x.png' class='' style='max-width:1087px; width:100%' alt=''>

__Save all changes and restart your server.__

If all went well, you should see Laravel's default welcome page when you visit `http://localhost` in your browser:

<img src='http://making-the-internet.s3.amazonaws.com/laravel-app-setup-success@2x.png' style='max-width:686px; width:100%'>

Whenever configuring a server to run Laravel, always remember **the Document Root has to point to the `public/` folder within your app directory**.



## Version Control your new app
In this course, you've created three applications so far:

1. The `hello-world` example
2. Your Project 1 application
3. Your Project 2 application

In all three of these cases, you started with a blank slate (i.e. no files), so the process setting up git looked like this:

1. Create a new, empty repository in Github
2. Clone this repository to your local machine

With this new Laravel application we've just created, though, we are not starting with a blank slate- we have all the skeleton Laravel code. Our process, then, for setting up version control for this app will be a little different:

1. Initiate git in the application's folder on your local machine
2. Create a new, empty repository on Github.com
3. Connect your local repository to the new repository on Github.com.

Here are the steps to do that...

In your application directory, initiate a new Git repository using the command `git init`

```bash
$ cd /path/to/foobooks
$ git init
```

Then, on Github.com, create a new repository. When doing this, do *not* initialize the repository with a `README.md` file because you'll be working with a repository that has already been initialized.

<img src='http://making-the-internet.s3.amazonaws.com/laravel-foobook-repo@2x.png' class='' style='max-width:735px; width:100%' alt='Foobooks repo setup in Github'>

Note the Github SSH URL, for example, `git@github.com:username/foobooks`

Back in your application directory, add a new remote origin called `origin`, that is set to the Github SSH path:

```bash
$ git remote add origin git@github.com:username/foobooks.git
```

You now have a git tracked application locally, that is connected to a repository on Github.



### First commit
Run git status to see all your untracked files:

```bash
$ git status
```

Add all your files for committing:

```bash
$ git add --all
```

Commit these changes:

```bash
$ git commit -m "First commit"
```

Push your project to Github:

```bash
$ git push origin master
```

When you visit your repository on Github you should see all your changes there.

Your app is now set up locally and ready for development. In the next section, we'll cover the procedure for deploying your app to a live server.


## Troubleshooting
If your new app won't run, check for clues in `storage/logs/laravel.log` first, as that's where Laravel outputs errors.

The following are some common problems and solutions students have faced.

### Composer installs an older version of Laravel
If Composer is downloading an older version of Laravel than you're expecting, it could be because your PHP in command line is out of date, and Composer is getting the latest version of Laravel supported by that version.

Confirm by running `php --version`

It should report back >= 7.

If it's 5.5 or less, you will get an older version of Laravel. Revisit the Composer Setup notes where it talks about checking/setting your PHP version in Command Line.


### Cache permission error when creating a new Laravel project with Composer
If you see the following warning when installing Laravel w/ Composer...

```xml
Cannot create cache directory [your home directory].composer/cache/repo/https---packagist.org/, or directory is not writable. Proceeding without cache.
```

...it means that Composer lacks the appropriate permissions to write cache files to the `.composer/cache` directory

This appears to be an issue isolated to Mac users, and can be fixed by running the following command:

```
$ sudo chown -R $USER $HOME/.composer
```

Run this command exactly as is, you do not need to edit it, as `$USER` and `$HOME` are dynamic variables that will fill in with your computer's username and home directory.

This command will recursively (`-R`) set you (`$USER`) as the owner of the `.composer` directory. That way when you run commands as Composer, it will have the appropriate permissions needed to write files to its cache directory.


### No supported encryptor found
If you see the error `No supported encryptor found.` chances are it means the `APP_KEY` in your environment file is not properly set.

This should not happen on a new installation, as generating the app key is something the Laravel installer does. However, if for some reason your app key is not set, you can fix it with this command:


```php
$ php artisan key:generate
```


## Read More
+ <https://laravel.com/docs/installation>
