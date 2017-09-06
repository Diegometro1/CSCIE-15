# Syntax

## Practice work
Suggestion: Create a new directory in your htdocs folder called `php-examples` where you can store all the examples you'll be working on in the upcoming notes. Set your local server's document root to this directory so that you can access it via `http://localhost`.

For this note set, create a new file, `php-examples/syntax.php` and paste in the following code:
```php
<?php
$temperature = 75;
$scale = "F";
$location = 'Cambridge';

echo 'Temperature in '.$location.': '.$temperature.' '.$scale;
?>
```

Load this file in your browser via your local server (`http://localhost/syntax.php`); it should look like this:

<img src='http://making-the-internet.s3.amazonaws.com/php-syntax-in-browser@2x.png' style='max-width:595px;' alt='Basics PHP page loaded in the browser'>

Study each line of the example and note that it...

Sets 3 variables (an Integer and two Strings):

```php
$temperature = 75;
$scale = "F";
$location = 'Cambridge';
```

And outputs a String using the [echo](http://php.net/manual/en/function.echo.php) construct:
```php
echo 'Temperature in '.$location.': '.$temperature.' '.$scale;
```

Additional observations...
* PHP code is surrounded by a start PHP tag `<?php` and an end PHP tag `?>`.
* PHP statements end with a semi-colon.
* Variables are indicated with a `$` sign.
+ Values are assigned to variables using the *assignment operator* `=` (equal sign).
* Strings can be surrounded in single (`'F'`) or double quotes (`"Cambridge"`).
* Values can be joined together using the concatenation operator `.` (period).


## View Source
Use your browser's *View Source* feature to look at the underlying source code your browser processes. Note how you don't see the PHP code since it's processed on the server rather than the browser; you only see any resulting output.

<img src='http://making-the-internet.s3.amazonaws.com/php-syntax-view-source@2x.png' style='max-width:595px;' alt='View source of the basics example'>


## Comments
PHP supports the following comment styles:

```php
<?php

// This is a one-line c++ style comment
echo 'This is a test';

/* This is a multi line comment
   yet another line of comment */

echo 'This is yet another test';

# This is a one-line shell-style comment
echo 'One Final Test';

?>
```

And these styles can be used to organize and comment your code in various ways:
```php
<?php
//=====================================================
// CATEGORY LARGE FONT
//=====================================================

//-----------------------------------------------------
// Sub-Category Smaller Font
//-----------------------------------------------------

/* Title Here Notice the First Letters are Capitalized */

# Option 1
# Option 2
# Option 3

/*
* This is a detailed explanation
* of something that should require
* several paragraphs of information.
*/

// This is a single line quote.
?>
```

Your comment styling is up to you&mdash; just aim for consistency.

When we get to Laravel we'll see DocBlock style comments that follow a specific structure in order to generate documentation using something like [phpDocumenter](https://phpdoc.org):

Example:
```
<?php
/**
 * Show the profile for the given user.
 *
 * @param  int  $id
 * @return Response
 */
public function showProfile($id)
{
    return view('user.profile', ['user' => User::findOrFail($id)]);
}

[...]
```

You are not required to use DocBlock style comments in your assignments; showing here just for reference.


## A note on PHP tags in upcoming examples
From this point forward, example PHP code will be shown without PHP start/end tags for the sake of brevity.

I.e., instead of this:
```
<?php
echo 'Hello World';
?>
```

You'll see this:
```php
echo 'Hello World';
```

The only exception to this is the note set on mixing PHP and HTML where PHP start/end tags will be used to distinguish from HTML code.
