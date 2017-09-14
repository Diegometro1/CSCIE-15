Ideally, you should work with code editor that supports PHP as will give you access to tools that will make writing and debugging PHP code easier.

An example of a very php-friendly editor is an Integrated Development Environment (IDE) like [PHPStorm](https://www.jetbrains.com/phpstorm) ([student license](https://www.jetbrains.com/student)) which is packed with both general and PHP-specific tools.

PHPStorm is a fantastic program, but it has a steeper learning curve than a more general editor, and might be overwhelming if you're not used to working with IDEs.

Alternatively, a more general editor like [Atom](https://atom.io) may be easier to work with, while still providing essential PHP-related tools.


__Atom indicating PHP errors in code:__
<img src='http://making-the-internet.s3.amazonaws.com/php-errors-in-atom@2x.png' style='max-width:597px;' alt='PHP Errors in Atom'>

__Note @ Wed Sep 13 11:45pm:__ *It's been drawn my attention that the package setup instructions for this particular feature has changed. I'll work on revised instructions to be posted either this Thu or Fri and I'll send out an announcement when they're ready.*

<br>
__Atom providing PHP autocomplete functionality__

Using the package [autocomplete-php](https://atom.io/packages/autocomplete-php)
<img src='http://making-the-internet.s3.amazonaws.com/php-autocomplete-in-atom@2x.png' style='max-width:527px;' alt='Autocomplete PHP in Atom'>

<br><br>
It is not required that you use Atom in this course; many other editors are capable of the same features and you are welcome to use whatever editor you prefer.

The following is a summary of common Atom features you'll see me using during lectures.

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
