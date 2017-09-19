# Classes

## Object Oriented Programming
Object Oriented Programming (OOP) is a style of programming that aims to create clean, maintainable, reusable code.

Of course, OOP is not unique to PHP, but let's cover the basics and look at the syntax for using OOP in PHP.


## Classes and Objects
OOP Starts with **classes**.

A class often defines a specific data entity of your project, for example, the Foobooks application might have a Book class, or an Author class.

Classes can contain **properties** and **methods**.

__Properties__ are the characteristics of the class, e.g. a Book class might have these properties:

+ `title`
+ `author`
+ `publishedDate`
+ etc.

__Methods__ are things that class can do, e.g. a Book class might have these methods:

+ `update`
+ `delete`
+ `getSimilar`

This can be summarized as follows: *A class has characteristics (properties) and it can do things (methods)*.

Outside the context of OOP, *properties* are essentially *variables*, and *methods* are essentially *functions*.

From classes comes __objects__.

If a class is a cookie-cutter, the object is the cookie.

In lecture, we'll look at four different example classes:

1. `Cipher` - a class that mimics the kind of work you may do in Project 2
2. `Form` - a class to help with working with forms, including validation methods
2. `Library` - a class to help organize our foobooks work thus far
4. `Helper` - a static class we'll create from the existing code in `helpers.php`


## The basics
Class names should always be written in `UpperCamelCase`, e.g. `Book`

Individual classes are stored in their own file, and the file name matches the class name. E.g. `Book.php`.

A class file is structured like this:

```
<?php
class Book {

	# Properties

	# Methods
}
```

Typically, the only thing in a class file is the class itself. The class is then imported in some other file where it'll be used.

To use a class, you instantiate an object from the class using the `new` keyword. For example:

```php
<?php
require('Book.php');

$book = new Book();
```


## Properties
+ A property is a variable that belongs to a class.
+ Properties are typically defined at the top of a class.
+ Properties can be prefixed with the keyword `public`, `private`, or `protected`
	+ **public**: property is accessible inside and outside the object
	+ **private**: property is only accessible inside the object
	+ **protected**: property is accessible inside the object and any objects which inherit this object
+ You can assign simple defaults to properties (ex: `15`, `false`, `foobar`), but you can not assign expressions (ex: `15 - 5`, `$foo * 2`).


## Methods
+ A method is a function that belongs to a class.
+ `$this` is a built-in variable that is a reference to the current object's methods and properties.
+ `public` is an example of an **access modifier** which controls where an object's method can be accessed from.
+ Access modifier options:
	 + **public** : method is accessible inside and outside the object
	 + **private** : method is only accessible inside the object
	 + **protected** : method is accessible inside the object and any objects which inherit this object
	 + **static** : no object instantiation is needed; can be called directly on the class. This modifier can be added in addition to the `public`, `private` or `protected` modifiers. For example, you can say: `public static foobar() {}` to declare that a method is both `static` *and* `public`.


## Magic Methods
Classes can contain [PHP magic methods](http://php.net/manual/en/language.oop5.magic.php), which are predefined methods that have built-in functionality.

For example, your class can have a `__construct()` magic method. What makes this method &ldquo;magical&rdquo; is that it will automatically be invoked whenever you instantiate a new object of your class.

```php
class Book {

	# [...properties redacted...]

	/**
	*
	*/
	function __construct($title)
    {
		$this->title = $title;
	}

	# [...other methods redacted...]

}
```

Usage example:

```php
$book = new Book('The Great Gatsby');
```

Given this, if you have statements that you want executed *every time* a class is instantiated, put those statements in the construct method.




## Statically using classes
Generally, when using classes you first instantiate an object from that class.

For example, if you had a class called Email, you'd do something like this:

```php
$email = new Email();
```

And then maybe you'd write something like this (assuming your Email Class had a `send()` method):

```php
$email->send('jamal@gmail.com', 'Hello!');
```

Typically, instantiating objects from classes like this is the way to go.

However, you can also **statically** invoke a method from a class, which skips the step of invoking an object of that class.

This is done using the class name, followed by `::`, then the method name. For example:

```php
Email::send('jamal@gmail.com','Hello!');
```

The downside of statically using classes is you don't have the benefit of storing properties with the object, which is one of the great advantages of OOP.

However, there are some instances where you might have a class with some miscellaneous utility methods that don't necessarily have related data. In that case, statically using that class is acceptable.

If we were to bundle the functions from `helpers.php` into a Helper class, we'd see a good use-case of static methods:

```
Helper::dump($data);
```


## Namespacing

<http://php.net/manual/en/language.namespaces.rationale.php>:

> *What are namespaces? In the broadest definition namespaces are a way of **encapsulating items**. This can be seen as an abstract concept in many places. For example, in any operating system directories serve to group related files, and act as a namespace for the files within them. As a concrete example, the file `foo.txt` can exist in both directory `/home/greg` and in `/home/other`, but two copies of `foo.txt` cannot co-exist in the same directory. In addition, to access the `foo.txt` file outside of the `/home/greg` directory, we must prepend the directory name to the file name using the directory separator to get `/home/greg/foo.txt`. This same principle extends to namespaces in the programming world.*

Namespacing is a principle in programming that allows us to prevent **name collisions**.

Name collisions occur when two different packages of code try to use the same class names.

This can be problematic, because applications often rely on external packages to perform common functions. For example, let's imagine you're building a weather application that will notify users if there's a storm warning in their area. To accomplish this, you find two external packages that you'll integrate into your project:

+ The first is a package called *Texter* that lets you send text messages to your user.
+ The second is a package called *AutoCaller* that lets you send automated voice messages to your user.

Both of these packages have a class called `Message`.

So if you write...

```php
$message = new Message();
```

...how does your code know *which* Message class you're trying to use&mdash; the one from *Texter* or the one from *AutoCaller*?

The solution to this problem is __namespacing__. Using namespacing, you can specify in more detail *which* Message class you're trying to use.

Here's a basic example:

```php
$message1 = new Texter\Message;
$message2 = new AutoCaller\Message;
```
