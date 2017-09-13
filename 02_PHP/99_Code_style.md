# Code style
It's common for development teams to have a coding style guide&mdash; a set of rules for how code should be written, which covers details like:

+ Case conventions - e.g., when/where to use lowerCamelCase, snake_case, UpperCamelCase, etc.
+ Structural conventions - e.g., whether to use spaces or tabs, where to place braces, what's the maximum length a line of code should be, etc.
+ Etc...

The purpose of a style guide is to keep work consistent amongst a group of developers. Even if you're working independently, abiding by a style guide will help produce more consistent code that's less prone to errors.

As an example, this is the [Ruby style guide that the team at Github.com uses](https://github.com/github/rubocop-github/blob/master/STYLEGUIDE.md).

On a more macro level, sometimes entire languages have dedicated style guides, such as the case with [Python's PEP 8 style guide](https://www.python.org/dev/peps/pep-0008/).

PHP has two style guides maintained by the [PHP Framework Interop Group (FIG)](http://www.php-fig.org):

+ [PSR-1 Basic Coding Standard](http://www.php-fig.org/psr/psr-1)
+ [PSR-2 Coding Style Guide](http://www.php-fig.org/psr/psr-2/)

When a language has an official style guide, it's not required that it be implemented 100%, and teams may decide to go off course with their own variations. The emphasis on style is not about which style guide you're following, simply that you are following *some* style guide and are aiming to be consistent and thoughtful in regards to code design.

__In this course, we will strive to follow the PSR-1/PSR-2 guidelines. If you diverge from these guidelines you won't lose points, as long as you do so consistently within your own work.__ Examples below.


## Code neatness
While you won't be penalized for breaking specific guidelines of the PSR-1/PSR-2 guidelines, you may lose points for code that is inconsistent and messy.

Consider the following sloppy code example. What is wrong with it?

```php
function getCelsius(int $temperature, $includeUnit = true) {

    # $x = ($temprature * 1.8 + 32 # f -> c
    $x = ($temprature - 32) / 1.8;


    if ($includeUnit) {

    return $x .= ' C';
    }
    else{
        return $x;


    }
}
```

Problems:
+ The spacing between lines varies with no rhyme or reason.
+ Incorrect indentation&mdash; the first `return` statement is a child of the `if` construct and thus it should be indented.
+ Inconsistent spacing of braces after the `if` and `else`.
+ The variable name `$x` is generic and in a larger context it could be confusing. A better name would be `$result`.
+ While it works, there's a typo in the variable name (`$temprature` should be `$temperature`).
+ There's a commented-out line of code that's not being used, and no context is provided as to why it's still there. Lines like this should be cleaned up when finalizing a project.

Here's that same example, cleaned up so its consistent and follows all PSR-1/PSR-2 guidelines:
```php
function getCelsius(int $temperature, $includeUnit = true)
{
    $result = ($temperature - 32) / 1.8;

    if ($includeUnit) {
        return $result .= ' C';
    } else {
        return $result;
    }
}
```

# Non-PHP code
There are no specific style guides I ask you adhere to when it comes to JavaScript, CSS, or HTML in your work.

However, just like PHP, it's expected that this code is consistent and neat for maximum legibility, following the best practices and requirements for the respective language.
