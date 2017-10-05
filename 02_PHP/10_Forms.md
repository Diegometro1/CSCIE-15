# Forms

All of the examples thus far have excluded a necessary ingredient of a web application: __input from the user__.

The most common way you'll get input from your user is via HTML forms that will submit to your server.

(If you're not comfortable with HTML form elements, take the time now to skim through this article: [MDN Forms](https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/My_first_HTML_form))

To understand how form processing works, it's important to understand that the web works via this two-step process:

+ __Request:__ A client (web browser) sends a request to a server (in our case, Apache) via the HTTP protocol.
+ __Response:__ The server responds to the request (also via HTTP)

<img src='http://making-the-internet.s3.amazonaws.com/php-request-response@2x.png' style='max-width:521px;' alt=''>

A request will include essential data such as...

+ What is the address of the request?
+ Is there any cookie data with the request?
+ What is the IP address from which the request is coming from?
+ What client type (i.e. browser) is the request coming from?

In addition to these details, input data from the user can also be sent as part of the request.

How the data is sent depends on what request type is being used&mdash; HTTP protocol supports two types: GET and POST.

+ When you visit a web page, the GET method is used.
+ When you submit a form to a web page, either the GET or POST method can be used.



## GET Example
This semester, many of our demos will revolve around an example application called **foobooks**, which is a simple interface for organizing a collection of books.

With that in mind, let's build our very first iteration of foobooks and demonstrate processing a form with the GET method.

Create a new file called `foobooks.php` with this code:
```php
<form method='GET' action='search.php'>

    <label>Search for a book:
        <input type='text' name='searchTerm'>
    </label>

    <input type='submit' value='Search'>

</form>
```

And a second new file called `search.php` with this code:
```php
<?php
var_dump($_GET);
echo 'You searched for '.$_GET['searchTerm'];
```

Observations about `foobooks.php`:
+ The form element has a `method` attribute set to `GET`
+ The form element has an `action` attribute, specifying where this form should be submitted to (`search.php`).
+ The single input in the form has a `name` attribute, which will be used to identify that data

Run the above example and submit with the search term &ldquo;fiction&rdquo;.

<img src='http://making-the-internet.s3.amazonaws.com/php-foobooks-search-with-get@2x.png' style='max-width:724px;' alt=''>

Looking closely at the brower's URL bar, you'll note that the form data is being sent with the request via the URL:

<img src='http://making-the-internet.s3.amazonaws.com/php-get-data-in-url@2x.png' style='max-width:547px;' alt=''>

In this example the URL is:
```xml
http://localhost/search.php?searchTerm=fiction
```

What follows the question mark is the query string:

```xml
searchTerm=foobar
```

A query string contains one or more key value pairs of data sent with the request. In this case, the key `searchTerm` was set to the value `fiction`.

If you had multiple form inputs, they'd be added to the query string, separated by a ampersand, e.g.:

```xml
http://localhost/search.php?searchTerm=fiction&minPublishedDate=1950
```

On the receiving end of things (i.e. `search.php`), data from the query string is available via an array, [`$_GET`](http://php.net/manual/en/reserved.variables.get.php).

`$_GET` is a PHP [superglobal](http://php.net/manual/en/language.variables.superglobals.php)&mdash; a built-in variable that's automatically created by PHP.

__GET Summary:__ Submit a form via the GET method and all the data from that form will be a) viewable in the URL bar and b) accessible in your script via the $_GET superglobal.



## POST Example
Update the above example with the following changes:

+ In `foobooks.php`, change the form method to POST
+ In `search.php`, change both occurances of $_GET to $_POST

Refresh `foobooks.php` and submit the form again.

The output should be the same, but this time the data is not appended to the URL; instead it's attached to the request &ldquo;behind the scenes&rdquo;.

<img src='http://making-the-internet.s3.amazonaws.com/php-form-post-results@2x.png' style='max-width:547px;' alt=''>

Note what happens when you refresh the page&mdash; it asks you if you want to re-submit the form data.

<img src='http://making-the-internet.s3.amazonaws.com/php-confirm-form-resubmission.png' style='max-width:547px;' alt=''>

To be demonstrated in lecture:
+ Exploring POST contents via the web inspector
+ Refreshing a POST submitted page

## GET vs. POST

GET...
+ GET Requests can be bookmarked, since the data is part of the URL.
+ GET Requests can only handle a limited amount of data; roughly 2k characters (give or take, depends on the browser).
+ GET Requests can only handle ASCII characters.
+ GET Requests should never be used for sensitive data (you don't want things like passwords revealed in the browser URL bar).
+ GET Requests should only ever be used to retrieve data (i.e. show me this book vs. save this book)

POST...
+ POST Requests can not be bookmarked; the lifecycle of the data only exists when the request is made.
+ POST has much larger data limits relative to GET, and the limits can be configured on your server.
+ POST Requests can handle binary file data in addition to ASCII characters (i.e. it can be used to upload files)
+ POST Requests should be used in cases where the data is effecting some change on the server. I.e. if a visitor is submitting a form to add a new book, that data will be saved to a database.



## Trust no one
When you open your web applications up to input from visitors, you need to develop a certain level of paranoia&mdash; always be on the lookout for ways in which malicious visitors will try and manipulate your application.

Security in our web applications is a common theme we need to explore this semester, and it starts here with form data...

Consider this example:

VisitorA is given a form where they can update the description of a book.

When filling out the form, instead of entering a valid description, they enter this nefarious JavaScript code:

```xml
<script>
    alert('Attention; your password has been compromised, visit http://shady.com to secure your account.')
</script>
```

Upon submission, the server saves this data to a database.

Later, VisitorB views the page for that specific book, and the description is fetched from the database and displayed on the page, resulting in an ominous alert message...

<img src='http://making-the-internet.s3.amazonaws.com/php-shady-alert@2x.png' style='max-width:422px;' alt=''>

Eep!

This scenario is called a **Cross-site scripting (XSS)** attack, and it occurs when a malicious visitor attempts to inject client-side scripts into web pages viewed by other visitors.

To avoid an attack like this, any data that originated from a visitor should always be &ldquo;sanitized&rdquo; before it's displayed on the page by converting HTML special characters to their equivalent HTML entities.

E.g. if the user entered this: `<script>` we should render it as `&lt;script&gt;` so that no scripts are actually executed on display.

This sanitization can be accomplished using PHP's built-in [htmlentities](http://php.net/manual/en/function.htmlentities.php) function, e.g.:

```php
<?=htmlentities($description, ENT_QUOTES, "UTF-8"); ?>
```

Which would output this:
```
&lt;script&gt;alert(&#039;Attention; your password has been compromised, visit http://shady.com to secure your account.&#039;)&lt;/script&gt;gt;
```

Looking ahead: Other security issues we'll discuss this semester include:
+ SQL Injection Attacks
+ CSRF (Cross Site Request Forgery)




## Sanitize helper
There's a helper function in [`helpers.php`](https://github.com/susanBuck/dwa15-php-practice/blob/master/helpers.php) called `sanitize` that can be used to conveniently run htmlentities on a single data entity, e.g.:

```php
$_POST['name'] = sanitize($_POST['name']);
```

Or it can recursively iterate through and sanitize an array, e.g.:

```php
if($_POST) {
    $_POST = sanitize($_POST);
}
```


## Form design flow
There are different ways you can design your form flow.

In the above example, we used a design that involves 2 scripts, like this:
<img src='http://making-the-internet.s3.amazonaws.com/php-form-designA@2x.png' style='max-width:402px;' alt=''>

The con of this design is the visitor can refresh the search.php page and re-submit the form data, which might not be ideal if, for example, the purpose of the form is to add a new entry to a database.

To address this issue, the following alternative design could be used:
<img src='http://making-the-internet.s3.amazonaws.com/php-form-designB@2x.png' style='max-width:625px;' alt=''>

In this design, the form data is handled on the search.php page, and the user is immediately redirected to the confirmation page (`done.php`). If they refresh the confirmation page, there's no harm, as it does not have access to the form data.

The con of this design is if you want to, for example, show a confirmation page with the data the user entered, you would no longer have access to this data in the POST superglobal. You'd have to add extra code that would store the data in a Cookie or Session so it could be retrieved and displayed on the confirmation page.

The final design manages all three phases of the form process via one page:
<img src='http://making-the-internet.s3.amazonaws.com/php-form-designC@2x.png' style='max-width:247px;' alt=''>

Potential Con: Like Design A, the visitor can resubmit the form data by refreshing the page.

Pros: If a user is using the form to edit something (e.g. info about a book), it's often desirable to display the form again with the same data after the work is saved.

__For Project 2, you can use any of these designs.__



## More form input type examples
Beyond text inputs (shown in the examples above), your project may also require checkboxes, radios, or drop-down inputs. Examples of each can be seen at the following urls.

+ Examples: http://php-practice.dwa15.com/forms/
+ Code for examples: <https://github.com/susanBuck/dwa15-php-practice/tree/master/forms>
