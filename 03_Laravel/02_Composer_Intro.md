## What is Composer?
* Dependency manager for PHP; equivalent to Node's *NPM* and Ruby's *Bundler*
* A dependency is simply some code library/package/plugin that your project utilizes; i.e. it depends on it.
* Composer is the dependency manager that Laravel uses, and so we have to set it up and understand how to use it.
* Composer is a command line program:
<img src='http://making-the-internet.s3.amazonaws.com/laravel-composer-logo-in-command-line@2x.png' class='' style='max-width:776px; width:100%' alt='Composer called in command line'>


## In a nutshell
In a project managed with Composer, you have a configuration file (`composer.json`) where you specify the dependencies your application has. For example:

```json
 "require": {
        "php": ">=5.6.4",
        "laravel/framework": "5.4.*",
        "laravel/tinker": "~1.0"
    },
    "require-dev": {
        "fzaninotto/faker": "~1.4",
        "mockery/mockery": "0.9.*",
        "phpunit/phpunit": "~5.7"
    },
```

Composer then reads this configuration and downloads the necessary files.

Packages available for management via Composer are listed on [Packagist](http://packagist.org).


## Tangental feature of Composer: Autoloading
[Autoloading](http://php.net/manual/en/language.oop5.autoload.php) allows you to access Classes in your application without having to explicitly include the Class file.

Instead, you can provide a map for your application where it will look for classes and load them, on-demand, as needed.

With autoloading, you no longer have to do something like this:
```php
include('Form.php');

$form = new DWA\Form;
```

Instead, your application can find the class for you, so you only need to do this:

```php
$form = new DWA\Form;
```

It seems trivial in this small example, but it's a very useful feature to have as the complexity of your application grows and with it, your usage of Classes.

One of features of Composer is that it builds and manages a class map for you, allowing you to harness auto-loading.

You don't have to worry about using/understanding auto-loading right now, just know that when we use it, it's being powered by Composer.


## Composer = server-side packages
To be clear, Composer will be used to manage __server-side, PHP-based packages__. You will not use Composer for client-side packages such as jQuery or Bootstrap. If/how you incorporate client packages in your projects is up to you - you can manually download them to your project, link them from a CDN, or use a client-side package manager such as [yarn](https://yarnpkg.com/en).

## Docs
<https://getcomposer.org/doc>
