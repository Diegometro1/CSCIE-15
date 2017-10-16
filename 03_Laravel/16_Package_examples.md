# Package examples

## barryvdh/laravel-debugbar
For our first example, we're going to install __barryvdh/laravel-debugbar__, which adds a useful debugging/info panel to your Laravel application.

+ <https://packagist.org/packages/barryvdh/laravel-debugbar>
+ <https://github.com/barryvdh/laravel-debugbar>

<img src='http://making-the-internet.s3.amazonaws.com/laravel-debug-preview@2x.png' style='max-width:1051px;' alt='Preview of the laravel-debugbar'>

Following the [instructions](https://github.com/barryvdh/laravel-debugbar), we'll install this package using the `composer require` command, followed by the full name of the package (including the vendor). The `--dev` flag is added so that this package only installs on our local/development server (not production). This is logical since the debugbar is only something we want to use during development, and is not something our users on production need to interact with.

```bash
$ composer require barryvdh/laravel-debugbar --dev
```


After you run the `composer require` command, if you open `composer.json`, you'll see your `require-dev` section now includes a line for the `barryvdh/laravel-debugbar`:

```json
"require-dev": {
    "barryvdh/laravel-debugbar": "^3.1",
    "filp/whoops": "~2.0",
    "fzaninotto/faker": "~1.4",
    "mockery/mockery": "0.9.*",
    "phpunit/phpunit": "~6.0"
},
```

Also, you should now see a `barryvdh/laravel-debugbar/` directory in your `vendors/` directory:

<img src='http://making-the-internet.s3.amazonaws.com/laravel-debugbar-in-vendors@2x.png' style='max-width:278px; width:100%' alt=''>

(Actual files you see may vary from this screenshot, depending on the version you have)

### Using Debugbar
Debugbar is built using a Laravel feature called *package discovery* which means that upon installation you can immediately start using it without any further configuration.

Load any page in your app to test it out.

<img src='http://making-the-internet.s3.amazonaws.com/laravel-debug-bar-open@2x.png' style='max-width:1000pxpx; width:100%' alt=''>

### Debugbar messages
But, there's more. Further down in the Debugbar documentation, there's some *Usage* examples where it demonstrates outputting different kinds of message to the Debugbar.

Let's take those instructions and test them out in a temporary `/debugbar` route:

```php
Route::get('/debugbar', function () {

    $data = ['foo' => 'bar'];
    Debugbar::info($data);
    Debugbar::info('Current environment: '.App::environment());
    Debugbar::error('Error!');
    Debugbar::warning('Watch out…');
    Debugbar::addMessage('Another message', 'mylabel');

    return 'Just demoing some of the features of Debugbar';
});
```

When you run the `/debugbar` route, if you look at the **Messages** tab of the debug bar, you should see the various outputs:

<img src='http://making-the-internet.s3.amazonaws.com/laravel-messages-in-debugbar@2x.png' style='max-width:1000px; width:100%' alt=''>

Being able to output messages like this will be extremely useful when building and debugging your applications.


## cebe/markdown
For our next example, we're going to use the Package called [__cebe/markdown__](https://github.com/cebe/markdown) which provides functionality for converting Markdown text to HTML. (Perhaps we could use this functionality in Foobooks to allow users to write book descriptions and/or reviews using Markdown syntax.)

This particular package is not built specifically for Laravel, but it will work.


### Installing
To install `cebe/markdown`, instead of using `composer require` we'll update `composer.json` adding `"cebe/markdown": "^1.1",` to the `require` section. (Unlike `debugbar`, it's logical we would want to use this package on production, which is why it goes in `require`, not `require-dev`).

```json
{
    "name": "laravel/laravel",
    "description": "The Laravel Framework.",
    "keywords": ["framework", "laravel"],
    "license": "MIT",
    "type": "project",
    "require": {
        "php": ">=7.0.0",
        "fideloper/proxy": "~3.3",
        "laravel/framework": "5.5.*",
        "laravel/tinker": "~1.0",
        "cebe/markdown": "~1.1.1"
    },
    "require-dev": {
        "barryvdh/laravel-debugbar": "^3.1",
        [...]
    },
}
```

After adding this line, run `composer update` to have Composer download that package.


### Usage
Taking from the [instructions](https://github.com/cebe/markdown), we then set up the following example in the [PracticeController](https://github.com/susanBuck/dwa15-fall2017/blob/master/03_Laravel/99_Practice_Work.md).

```php
public function practiceX()
{
    $parser = new \cebe\markdown\MarkdownExtra();
    echo $parser->parse('# Hello World'); # Will produce <h1>Hello World</h1>
}
```

This example works by including the full namespace leading to the MarkdownExtra class (that's part of the `cebe/markdown` package). Note how the namespace is prefixed with a backslash (`\`) so that our autoloader will look for this class in the global namespace instead of the controller's namespace.

This works, but specifying the full namespace would be inconvenient if we wanted to use this class repeatedly.

There's two alternative options:

### Alternative Option 1 - use statement:
You can implement the [`use`](http://php.net/manual/en/language.namespaces.importing.php) statement at the top of your PHP file to import the class. Then, when you use the class, you can simply say `new MarkdownExtra()`.

Example:

```php
use cebe\markdown\MarkdownExtra;

# [...]

public function exampleX()
{
    $parser = new MarkdownExtra();
    echo $parser->parse('# Hello World'); # Will produce <h1>Hello World</h1>
}
```

### Alternative Option 2 - alias:
If you anticipate using a class frequently throughout your application, you can create a global __alias__ for it.

This is done in `/config/app.php` in the array called `aliases`.

Here's an example of how you'd update the `aliases` array in `/config/app.php` to add `MarkdownExtra`:

```php
'aliases' => [
    'App'       => Illuminate\Support\Facades\App::class,
    'Artisan'   => Illuminate\Support\Facades\Artisan::class,
    [...etc...]
    'View' => Illuminate\Support\Facades\View::class,
    'MarkdownExtra' => cebe\markdown\MarkdownExtra::class, # <-- NEW
],
```

The *key* is the alias name you want to use (`MarkdownExtra`) and the *value* is the full path to the class, including the namespace (`cebe\markdown\MarkdownExtra::class`). (Aside: explanation of [`::class`](https://gist.github.com/susanBuck/ec6df60761cf666d113ffc7b60e407f2))

Once you've set up this alias, you can call the `MarkdownExtra` class with no namespace (but you still need the backslash):

```php
public function exampleX()
{
    $parser = new \MarkdownExtra();
    echo $parser->parse('# Hello World'); # Will produce <h1>Hello World</h1>
}
```


### Which option is best?
Which method you want to use is up to you, but here's a general guideline:

+ Using a Class just once?
    + Go with the full namespace, e.g. `$parser = new \cebe\markdown\MarkdownExtra();`
+ Using a Class multiple times in a single file?
    + Set `use cebe\markdown\MarkdownExtra;` at the top of the file.
+ Using a Class multiple times throughout your application?
    + Create an alias.


## Deploying packages to production
If you deploy new code to your production server that involves the addition or removal of a package, you need to run `composer install --no-dev` on production so it will sync up your packages.

Note the command for production is `composer install --no-dev`, not `composer update` which you've been using locally. The difference:

* Use `composer update` on __development environment(s)__ so it grabs the package versions set in your `composer.json` file and updates your `composer.lock` file to match these versions.

* Use `composer install --no-dev` on __production environment(s)__ so it grabs the package versions set in your `composer.lock` file (i.e. mirror the versions exactly as they are on the development environment). The `--no-dev` flag is added so it excludes packages specified in `require-dev`.


## Composer dump autoload
When adding new class files to your program, you may be perplexed when you go to use those classes and you see errors that they're not found.

This can happen because Composer maintains a map of all classes in your application to make loading those classes faster. If you add a new class but the class map has not been updated to reflect this change, your app may fail at locating that class.

The fix is simple; at any point you can run the command `composer dump-autoload` to generate a fresh class map.

This command should not be necessary when adding classes as we did in this note set, because `composer update` and `composer require` should also update the class map, but it's a command that may come in handy when you start adding your own classes.

```xml
$ composer dump-autoload
Generating autoload files
```


## Troubleshooting

### Issue: minimum-stability missing
Sometimes when you attempt to install a package with `composer require` you'll see a message telling you the package lacks a `minimum-stability`.

For example, you can see this with a package called [`paste\pre`](https://github.com/paste/Pre.php):

```xml
$ composer require paste/pre
[InvalidArgumentException]                                                                                           
Could not find package paste/pre at any version for your minimum-stability (stable). Check the package spelling or your minimum-stability    
```

This happens when a package is not using version tagging, and as a result Composer does not know what is the latest, stable version.

A workaround to this is to add the package by manually editing `composer.json`, setting the version of the package to `dev-master`:

```php
"require": {
    # [...existing packages...]
    "paste/pre": "dev-master"
}
```

Once you save these changes to `composer.json` you have to run `composer update` to have it go and grab that package.

You should avoid using packages that don't implement version numbers in important, production code. Without version numbers, you have less control over what version of the package you're getting, and it's always possible new versions could break your app without you realizing it at first.

In this case, since `pre` is a debugging tool, we could instead include it under `require-dev` and then it wouldn't matter as much that we weren't able to lock into specific versions.
