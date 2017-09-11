## Quick reference

Config file: `/etc/apache2/sites-enabled/000-default.conf`

Restart Apache: `service apache2 restart`

VirtualHost template:
```xml
<VirtualHost *:80>
  ServerName hello-world.dwa15.me
  DocumentRoot "/var/www/html/hello-world"
  <Directory "/var/www/html/hello-world">
    AllowOverride All
  </Directory>
</VirtualHost>
```

## Domain setup
At this point, work on your DigitalOcean server can be viewed via your server's IP address.

Next, we want to set it up so that you can a) use a custom domain and b) run multiple applications from the server, each with their own subdomain.

In order to do this, you'll need a domain name.

If you have an existing domain you'd like to use, that's fine. If not, you can create a new domain name via a service like **[Namecheap](http://www.namecheap.com/?aff=61057)**. As of this writing, Namecheap is offering free domain names for students (with a `.edu` email address) via <https://nc.me>.

After you create your domain, find your **DNS settings** within your domain companies' control panel. In Namecheap, these settings are located by finding the domain you'd like to configure in your **Domain List** and then clicking **Manage**. Then, find the tab for **Advanced DNS**

In your DNS settings, set your `@` hostname to your DigitalOcean's server IP address.

Also, while you're there, add a new *A Record* with the *host* `hello-world` which also points to your DigitalOcean IP address. This will create the subdomain `http://hello-world.yourdomain.com`.

<img src='http://making-the-internet.s3.amazonaws.com/version-control-namecheap-dns@2x.png' style='max-width:1015px; width:100%' alt='Namecheap DNS'>

When you're done, click **Save all Changes**.

Give the above settings a few minutes to take effect, then test out your domain. You should see the same results you saw when you visited your server via the IP address, but this time it's loaded via your domain name.

<img src='http://making-the-internet.s3.amazonaws.com/vc-namecheap-domain-first-working@2x.png' style='max-width:945px; width:100%' alt='First domain working'>

__Aside regarding DNS management in DigitalOcean:__ It's possible to configure your domain so that it uses DigitalOcean's nameservers rather than your domain provider's nameservers, but that is not the setup we use in this course. Given this, there's nothing you need to do in  *DigitalOcean* > *Networking* > *Domains*. I recommend using different providers for domain management and server management so that if one fails, you still have access to the other.


### DNS Cache
If your domain is not working yet, it could be because the changes have not propagated on Namecheap's DNS yet, in which case you just have to wait it out. I've had the changes propagate within minutes, and other times its taken an hour or more.

A non-functioning domain after making DNS changes could also be related to caching on your own computer, so the following actions might get it working:

1. Clear your browser cache.
2. Clear your DNS cache
    + [Mac instructions](https://support.apple.com/en-us/HT202516)
    + Windows/Cmder run this command: `ipconfig /flushdns`.
3. Try a different browser.
4. Try accessing your URL via [this proxy](http://megaproxy.com/freesurf).
5. Ask a friend on a different computer/network to test it, or test it on your phone with wifi off (to force a different network).

If all of those tricks fail to show the domain is working, double check all your steps, and then continue to wait it out. If after an hour or so it's still not working, post a thread in [Issues](http://issues.dwa15.com) describing the problem with a screenshot of your DNS settings.


## Virtual Host/Subdomain setup
Your primary domain is working, now let's get a subdomain working (`http://hello-world.domain.com`).

In the above steps, you already set up the DNS for the subdomain, making it so that traffic via `http://hello-world.domain.com` will point to your IP address.

Now we need to give the server instructions on what to do with this traffic.

This is done via a Virtual Host configuration; **Virtual Hosts allow Apache (your web server software) to be configured for multiple sites that have different configurations**.

To start, copy the following code into a new text editor window (your code editor, Notepad, Text Editor, whatever):

```bash
<VirtualHost *:80>
  ServerName hello-world.dwa15.me
  DocumentRoot "/var/www/html/hello-world"
  <Directory "/var/www/html/hello-world">
    AllowOverride All
  </Directory>
</VirtualHost>
```

In plain English, this VirtualBlock block code says: *when traffic comes in via `hello-world.dwa15.me`, point to the `/var/www/html/hello-world` directory*.

Edit this VirtualHost block so that the the `ServerName` (`hello-world.dwa15.dev`) value matches *your* domain.

Also change the `DocumentRoot` **and** `Directory` path to match the path to your hello-world directory on DigitalOcean, if it's different from the example.

With your edits in place, we'll now show you where to put this code on your server...

SSH into your DigitalOcean server.

Open `/etc/apache2/sites-enabled/000-default.conf` in nano:

```bash
$ nano /etc/apache2/sites-enabled/000-default.conf
```

This file is where your VirtualHost specifications live.

In nano, at the *bottom* of `000-default.conf`, paste in your edited VirtualHost block.

<img src='http://making-the-internet.s3.amazonaws.com/vc-pasting-virtual-host-block@2x.png' style='max-width:1152px'>

Tip for Cmder users: If you try and paste multiple lines into Cmder using keyboard shortcuts, it will paste just the first line. To get it to paste *all* the lines, right click the top bar in Cmder and choose `Edit` -> `Paste` ([screencast demo](http://screencast.com/t/u43zTSEx4GKl)).

When you're done editing the new VirtualHost block, save your changes to `000-default.conf` (`ctrl` + `x`, then `y`, then *Enter*).

(If for some reason you make a mistake in `000-default.conf`, [here's a copy of the original](https://gist.github.com/susanBuck/790ea5a0d1ad7d02e586).)

To make your VirtualHost changes take effect, restart Apache with this command:

```bash
$ service apache2 restart
```

Once the restart is complete, test out your subdomain `http://hello-world.yourdomain.com`.

<img src='http://making-the-internet.s3.amazonaws.com/version-control-subdomain-good@2x.png' class='' style='max-width:603px;' alt='Subdomain working'>



## Recap
Keep these notes handy for when you set up projects, because each project should operate from its own subdomain following this convention:

+ `http://p1.yourdomain.com`
+ `http://p2.yourdomain.com`
+ `http://p3.yourdomain.com`
+ `http://p4.yourdomain.com`

To recap, here were the steps we took to set up a new subdomain:

1. Open DNS settings in Namecheap (or whoever you domain provider is) and point your subdomain to your server's IP address.
2. Add a *new* VirtualHost to `/etc/apache2/sites-enabled/000-default.conf`. Each Subdomain will have its own VirtualHost block.
3. Restart Apache (`service apache2 restart`)


## Tips
+ Find out the IP address of a domain by executing: `ping domain.com`
+ Find out the nameserver of a domain by executing: `dig +short NS domain.com`
