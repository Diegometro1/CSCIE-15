With your Laravel application up and running locally, we now need to deploy it on your production server.

Before we can deploy, though, we need to do a few updates on your DigitalOcean server so it's set up with the necessary components that Laravel needs to run.

In these notes, we'll do the following:

1. Enable a swap file for more memory
2. Install Composer
3. Update PHP, install some necessary modules
3. Enable `mod_rewrite`


## Enable a swap file for more memory
Composer can be memory intensive, so we'll want to configure our low-memory DigitalOcean droplets to use a swap file.

>> "Swap is an area on a hard drive that has been designated as a place where the operating system can temporarily store data that it can no longer hold in RAM." -[ref](https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04)

To configure a swap file, run through the following commands.

First, create the swap file:

```xml
$ sudo fallocate -l 4G /swapfile
```

Next, adjust permissions on the resulting swap file so it isn't readable by anyone besides root:

```
$ sudo chmod 600 /swapfile
```

Next, tell the system to set up the swap space:

```xml
$ sudo mkswap /swapfile
```

Next, enable the swap space:

```
sudo swapon /swapfile
```

Finally, we want to make it so the server always enables this swap space, even after a reboot. To do this, open `/etc/fstab` with nano:

```
$ sudo nano /etc/fstab
```

...and paste in the following line at the end:

```
/swapfile   none    swap    sw    0   0
```

Save your changes (`ctrl` + `x`, then `y`, then *Enter*).

__Confirm it worked:__
You can confirm your swap file with the following command:

```
$ sudo swapon -s
```

Expected output:

```xml
Filename                Type        Size    Used    Priority
/swapfile               file        4194300 0       -1
```


## Install Composer
Move into your bin directory where you'll install Composer:

```bash
$ cd /usr/local/bin
```

Use cURL to download Composer:

```bash
$ curl -sS https://getcomposer.org/installer | sudo php
```

Rename the composer executable to `composer` so it's convenient to invoke:

```bash
$ sudo mv composer.phar composer
```

Test it's working:

```bash
$ composer
```

See a list of Composer commands? Good, you're ready to move to the next step...


## Install/update necessary modules
The image we built our DigitalOcean Droplets from came installed with PHP 7.0 but our local servers are running 7.1.

To avoid conflicts we want these two environments to be in sync so let's update PHP on the Droplet. We'll also install a few modules that Laravel needs.

To do this, we'll use `apt-get`, a command line utility for managing packages on Ubuntu's systems (which our Droplets run on).

Run the following commands, one at a time. Follow the instructions to hit `Enter` or `Y` (yes) when prompted.

```
$ sudo add-apt-repository ppa:ondrej/php
$ sudo apt-get update
$ sudo apt-get install php7.1 php7.1-mysql php7.1-xml php7.1-mbstring php7.1-xml zip unzip
$ sudo a2dismod php7.0
$ sudo a2enmod php7.1
$ service apache2 restart
```

When you're done, you can confirm PHP command line is running the correct version:

```xml
$ php --version
PHP 7.1.9-1+ubuntu16.04.1+deb.sury.org+1 (cli) (built: Sep  2 2017 05:56:43) ( NTS )
Copyright (c) 1997-2017 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2017 Zend Technologies
    with Zend OPcache v7.1.9-1+ubuntu16.04.1+deb.sury.org+1, Copyright (c) 1999-2017, by Zend Technologies
```


And you can confirm Apache is running the correct version by visiting `http://your-digitalocean-ip/info.php` (assuming you have not deleted that `info.php` file.)

<img src='http://making-the-internet.s3.amazonaws.com/laravel-digitalocean-post-php-upgrade-apache@2x.png' style='max-width:654px;' alt=''>


## Enable mod_rewrite
Laravel requires Apache's `mod_rewrite` for Routing purposes.

To enable this module, run the following command on your DigitalOcean droplet:

```xml
$ sudo a2enmod rewrite
```

Restart Apache to make these this change take effect:
```xml
$ sudo service apache2 restart
```




## Server setup complete!
At this point, you DigitalOcean Droplet has everything it needs to run a Laravel app. You're ready to move on to the next steps of deploying.


## Reference

+ [Ubuntu: How to manage software repositories from the command line](https://help.ubuntu.com/community/Repositories/CommandLine)
[ref](https://gist.github.com/susanBuck/f949e701c239a7468de64cd89fe0347b))
+ [Discrepancy between PHP versions on local vs. DigitalOcean](https://gist.github.com/susanBuck/f949e701c239a7468de64cd89fe0347b)
