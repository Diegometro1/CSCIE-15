# Week 13 Foobooks progress, Part A

The following is a very rough outline of some of the modifications I'll make to foobooks during Week 13.

This should not be considered a stand-alone document; for full details please refer to the lecture video and the foobooks code source.


## Author dropdown
To associate Authors with Books we'll use a dropdown filled with authors.

To make this happen, we first need an __array of authors__ where the key is the author `id` and the value is the author `name`.

```php
# BookController.php
public function edit($id)
{
    $book = Book::find($id);

    # Get all the authors
    $authors = Author::orderBy('last_name')->get();

    # Organize the authors into an array where the key = author id and value = author name
    $authorsForDropdown = [];
    foreach ($authors as $author) {
        $authorsForDropdown[$author->id] = $author->last_name.', '.$author->first_name;
    }

    # [...]

    # Make sure $authorsForDropdown is made available the view
    return view('book.edit')->with([
        'book' => $book,
        'authorsForDropdown' => $authorsForDropdown
    ]);
```

Then, we can construct the dropdown (`<select>`) using this data:

```html
<label for='author_id'>* Author:</label>
<select id='author_id' name='author_id'>
    @foreach($authorsForDropdown as $author_id => $authorName)
        <option value='{{ $author_id }}' {{ ($book->author_id == $author_id) ? 'SELECTED' : '' }}>
            {{ $authorName }}
         </option>
     @endforeach
</select>
```


Now in `saveEdits()` set the `author_id` using the data from the dropdown in `$request`:
```php
$book->author_id = $request->author_id;
```

Test it out to make sure it's working.



## Custom Model Methods
We'll want to do the same thing on the *Add a Book* page.

Rather than duplicate the &ldquo;get authors for dropdown&rdquo; code, we should extract it out of the controller and add it as a method to the `Author` model:

```php
# app/Author.php
public static function getForDropdown()
{
    $authors = Author::orderBy('last_name', 'ASC')->get();
    $authorsForDropdown = [];
    foreach($authors as $author) {
        $authorsForDropdown[$author->id] = $author->last_name.', '.$author->first_name;
    }

    return $authorsForDropdown;
}
```

Then in `edit()`:
```
$authorsForDropdown = Author::getForDropdown();
```

Other frequently used queries can also be abstracted, for example the following method could be added to the Book model:

```php
public static function getAllWithAuthors()
{
    return Book::with('author')->orderBy('id','desc')->get();
}
```

