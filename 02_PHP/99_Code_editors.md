Ideally, you should work in a code editor that supports PHP as it will give you access to tools that make writing and debugging PHP code easier.

An example of a very php-friendly editor is an Integrated Development Environment (IDE) like [PHPStorm](https://www.jetbrains.com/phpstorm) ([student license](https://www.jetbrains.com/student)) which is packed with both general and PHP-specific tools.

PHPStorm is a fantastic program, but it has a steeper learning curve than a more general editor, and might be overwhelming if you're not used to working with IDEs.

Alternatively, a more general editor like [Atom](https://atom.io) may be easier to work with, while still providing essential PHP-related tools.

In the following notes I'll explain how I have my Atom configured and also provide a list of common shortcuts I use. It's not required that you make these changes, use these shortcuts, or even use Atom at all&mdash; this is just information for those who wish to replicate features they see during lecture videos.


## Atom packages
Packages are plugins that allow you to add additional features to Atom.

If you're new to Atom, start by reading [this guide](http://flight-manual.atom.io/using-atom/sections/atom-packages) that explains how to install packages. As an example while you're reading this guide, install a package called `autocomplete-php`; this package will be useful because it will auto-complete built-in PHP functions as you type.

`autocomplete-php` in action:
<img src='http://making-the-internet.s3.amazonaws.com/php-autocomplete-in-atom@2x.png' style='max-width:527px;' alt='Autocomplete PHP in Atom'>


## Configure `autocomplete-php`
Once `autocomplete-php` is installed, you need to configure it so it knows where PHP is installed on your computer. To do this, open your packages in preferences.

+ Mac: Click `Atom` > `Preferences` then choose `Packages` from the side bar
+ PC: Click `File` > `Settings` then choose `Packages` from the side bar

Find the package `autocomplete-php` and scroll down to __Settings__ looking for the __PHP Executable Path__ field.

+ Mac users enter this: `/Applications/MAMP/bin/php/php7.1.6/bin/php`
+ PC Users enter this: `c:\xampp\php\php.exe`

<img src='http://making-the-internet.s3.amazonaws.com/php-set-autcomplete-php-package-path@2x.png' style='max-width:970px;' alt='Setting your PHP executable path'>

We'll test whether this worked in a moment, but first, let's install a couple more packages...

## Linter packages
If you want Atom to tell you about PHP syntax errors in your code while you work, you'll need some linter packages. In software, a linter is a program that checks code files against a set of syntax or style rules and flags problems.

Here's an example of a linter in action in Atom:
<img src='http://making-the-internet.s3.amazonaws.com/php-errors-in-atom@2x.png' style='max-width:700px;' alt='PHP Errors in Atom'>

To get this functionality, install the following 3 packages:

1. `linter`
2. `linter-ui-default`
3. `linter-php`

Just like `autocomplete-php`, the last package, `linter-php` needs to know where to find PHP on your computer. This time the configuration needs to happen in your Atom config file (`config.cson`).

+ Mac: Click `Atom` > `Config...`
+ PC: Click `File` > `Config...`

In your config file, find the setting for `"linter-php"` and set the executable path as follows.

Mac/MAMP:
```
  "linter-php":
    executablePath: "/Applications/MAMP/bin/php/php7.1.6/bin/php"
```

PC/XAMPP:
```
  "linter-php":
    executablePath: "c:\\xampp\\php\\php.exe"
```

Here's a screenshot of what the above changes look like in my Atom config file:

<img src='http://making-the-internet.s3.amazonaws.com/php-set-linter-php-package-path@2x.png' style='max-width:683px;' alt=''>


## Test out the packages
With the above packages installed, you can test your work. I find that sometimes Atom requires a restart to recognize certain packages/changes, so go ahead and do that first before testing.

Once Atom is re-loaded create a new file called `test.php` and save the following code:

```php
<?php

foo = bar;

```

(Note that in order for your PHP specific packages to work, the file you're working in must have a `.php` extension.)

If all your linter packages are set up properly, you should see a red line indicating a problem in this code, and when you hover it a dialog should appear with more details.

<img src='http://making-the-internet.s3.amazonaws.com/php-errors-in-atom@2x.png' style='max-width:700px;' alt='PHP Errors in Atom'>

You can also test out the `autocomplete-php` package by typing in `str` which should bring up a list of string related functions.

<img src='http://making-the-internet.s3.amazonaws.com/php-autocomplete-in-atom-with-str@2x.png' style='max-width:551px;' alt=''>


## Shortcuts
The following is a list of common shortcuts you'll see me using during lecture.

### Toggle tree view
+ Keyboard shortcut:
    + Mac: `Command` + `\`   
    + PC: `Ctrl` + `\`
+ Menu: *View : Toggle Tree View*

Toggles the tree view (file browser).


### Add project folder
+ Keyboard shortcut:
    + Mac: `Shift` + `Command` + `o`
    + PC: `Ctrl` + `Shift` + `A`
+ Menu: *File : Add Project Folder*

Adds a directory to your tree view so you have access to all the files in a project you're actively working on.


### Fuzzy finder
+ Keyboard shortcut:
    + Mac: `Command` + `p`
    + PC: `Ctrl` + `p`

Helps you quickly locate and open files from directories loaded in your tree view.


### Auto indent
+ Menu: *Edit : Lines : Auto Indent*

Highlight a section of code, then run this feature and it will correct the indenting on your code.

There's no default keyboard shortcut for this, but I assigned one to `command` + `shift` + `a`. To do this,
goto *Atom : Keymap...*

Add this:
```
'atom-text-editor':
    'cmd-shift-a': 'editor:auto-indent'
```

Caveat: If there are problems in your code, the auto-indenting can be thrown off.
