The following is a rough outline of the modifications I'll make to Foobooks during Lecture 12.

This should not be considered a stand-alone document; for full details please refer to the lecture video and the Foobooks code source.



## Add a book
Update `book/create.blade.php` to include `cover`, `purchase_link` fields.

Rename `publishedYear` field to `published` to match what we called it in the table.

Add the `old` helper for field values, and set default values to rapidly test:

+ Title: `Green Eggs & Ham`
+ Author: `Dr. Seuss`
+ Published: `1960`
+ Cover: `http://prodimage.images-bn.com/pimages/9780394800165_p0_v4_s192x300.jpg`
+ Purchase: `http://www.barnesandnoble.com/w/green-eggs-and-ham-dr-seuss/1100170349`

(We'll remove this when we're done debugging)

In `BookController.php` update `store` to validate the new fields added:

```php
$this->validate($request, [
    'title' => 'required|min:3',
    'published' => 'required|numeric',
    'author' => 'required',
    'cover' => 'required|url',
    'purchase_link' => 'required|url',
]);
```

Then save the book:
```php
$book = new Book();
$book->title = $request->input('title');
$book->author = $request->input('author');
$book->published = $request->input('published');
$book->cover = $request->input('cover');
$book->purchase_link = $request->input('purchase_link');
$book->save();
```

Currently redirects to the individual book, but let's change it to redirect to the book index:
```php
return redirect('/book');
```

If you do the latter, you will want to [flash](https://laravel.com/docs/5.5/redirects#redirecting-with-flashed-session-data) a confirmation message which can be done via redirect's `with` method:

```
return redirect('/book')->with('alert', 'Your book was added.');
```

Then in `master.blade.php`:
```php
@if(session('message'))
    <div class='alert'>{{ session('message') }}</div>
@endif
```

Which can be styled however you want:
```css
.alert {
    background-color:yellow;
    width:100%;
    position:fixed;
    top:0;
    left:0;
    padding:5px;
    font-weight:bold;
    text-align:center;
}
```


## Edit a book
Start `book/edit.blade.php` by copying `book/create.blade.php`.

Create the routes to a) show the edit form and b) process the edit form:
```php
# Show the form to edit a specific book
Route::get('/book/{id}/edit', 'BookController@edit');

# Process the form to edit a specific book
Route::put('/book/{id}', 'BookController@update');
```

Note the use of the `put` method here. In order to submit via PUT we need to use [form method spoofing](https://laravel.com/docs/5.5/routing#form-method-spoofing) like so:

```php
<form method='POST' action='/book/{{ $book->id }}'>

    {{ method_field('put') }}

    {{ csrf_field() }}

    [...]
</form>
```

Edit method to show the form:
```php
/*
* GET /book/{id}/edit
*/
public function edit($id)
{
    $book = Book::find($id);

    if (!$book) {
        return redirect('/book')->with('alert', 'Book not found.');
    }

    return view('book.edit')->with(['book' => $book]);
}
```

Update method to process the form:
```php
/*
* PUT /book/{id}
*/
public function update(Request $request, $id)
{
    $this->validate($request, [
        'title' => 'required|min:3',
        'author' => 'required',
        'published' => 'required|min:4|numeric',
        'cover' => 'required|url',
        'purchase_link' => 'required|url',
    ]);

    $book = Book::find($id);

    $book->title = $request->input('title');
    $book->author = $request->input('author');
    $book->published = $request->input('published');
    $book->cover = $request->input('cover');
    $book->purchase_link = $request->input('purchase_link');
    $book->save();

    return redirect('/book/'.$id.'/edit')->with('alert', 'Your changes were saved.');
}
```


## Delete a book
Try this one on your own. I'll share an example solution next week.
