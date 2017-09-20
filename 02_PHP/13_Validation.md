# Validation

Whenever you accept input from a visitor, that input needs to be validated.

Here are examples of the kind of validation you may see on Project 2:

+ An input asking for a Scrabble word should only accept letters.
	+ Pass: `apple`, `garage`
	+ Fail: `-1`, `99`, `0range`
+ A input asking for the length of a password should have a reasonable range like 1 to 10. It should also only allow positive integers.
	+ Pass: `1`, `5`, `10`
	+ Fail: `-1`, `abc`, `99`

Here are examples of validations you might see in a real world application:

+ An email input in a signup form should a) confirm it's a valid email address and b) the email address does not already exist in the system.
+ An input collecting a US zip code should have a min/max of 5 characters and only contain numbers
+ An input collecting a discount code should confirm the code is valid and not expired
+ etc...

Ultimately, validation should happen on both the client (via HTML + JavaScript) *and* the server (PHP).

The &ldquo;first-pass&rdquo; client-side validation via HTML and JavaScript can be used to give the visitor instant feedback about many issues and prevent form submission.

(Sometimes, the client-side validation may send a request to the server using Ajax to confirm data, e.g username does not already exist).

Once client-side validation passes, the form can submit to the server where a second-pass validation is done.

This second-pass validation step is necessary when working with important data because it's possible for users to bypass client-side validation using browser web inspector tools.

In this course, because our focus is on the server end of things, client-side validation is *optional*. It's not as optimal as having both, but it gets the job done for our purposes.

If interested, there is some &ldquo;low hanging fruit&rdquo; in terms of client-side validation via HTML5 validation attributes like `required`, `min`, `max`, `email`, etc. [You can learn more about these attributes here.](https://developer.mozilla.org/en-US/docs/Learn/HTML/Forms/Data_form_validation) Again, this type of validation is *not* required for projects in this course.


## Form helper
In Week 4's lecture videos, I'll introduce a class ([Form.php](https://github.com/susanBuck/dwa15-php-practice/blob/master/Form.php)) that has helper methods to assist you with form validation.

Examples:
+ Code: [dwa15-php-practice/formDemo.php](https://github.com/susanBuck/dwa15-php-practice/blob/master/formDemo.php)
+ Code: [dwa15-php-practice/formDemoLogic.php](https://github.com/susanBuck/dwa15-php-practice/blob/master/formDemoLogic.php)
+ In action: [formDemo.php](http://php-practice.dwa15.com/formDemo.php)
