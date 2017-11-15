The following is a rough outline of the modifications I'll make to foobooks during Lecture 12.

This should not be considered a stand-alone document; for full details please refer to the lecture video and the foobooks code source.


## List all the books
Amend `BookController@index` so the books are coming from the database instead of the .json file:

```php
use App\Book;

# [...]

public function index() {
    $books = Book::orderBy('title')->get();
    
    return view('books.index')->with([
        'books' => $books
    ]);
}
```



## Add a book
Update `book/new.blade.php` to include `cover`, `purchase_link` fields.

Rename `publishedYear` field to `published` to match what we called it in the table.

Mark all fields as required.

Add the `old` helper for field values, and set default values to rapidly test:

+ Title: `Green Eggs & Ham`
+ Published year: `1960`
+ Image URL: `http://prodimage.images-bn.com/pimages/9780394800165_p0_v4_s192x300.jpg`
+ Purchase URL: `http://www.barnesandnoble.com/w/green-eggs-and-ham-dr-seuss/1100170349`

(We'll remove this when we're done debugging)

In BookController.php update `storeNewBook` to validate the new fields added:

```php
$this->validate($request, [
    'title' => 'required|min:3',
    'published' => 'required|numeric',
    'cover' => 'required|url',
    'purchase_link' => 'required|url',
]);
```

Then save the book:
```php
$book = new Book();
$book->title = $request->title;
$book->published = $request->published;
$book->cover = $request->cover;
$book->purchase_link = $request->purchase_link;
$book->save();
```

Currently redirects to the individual book, but let's change it to redirect to the book index:
```php
return redirect('/book');
```

If you do the latter, you will want to [Flash](http://laravel.com/docs/session#flash-data) a confirmation message.

Before redirecting:
```
$request->session()->flash('message', 'Your book was added');
```

Explanation of a __flash messages/sessions__

Then in `master.blade.php`:

```php
@if(session('message') != null))
    <div class='message'>{{ session('message') }}</div>
@endif
```

Which can be styled however you want:
```css
.message {
    width:100%;
    text-align:center;
    padding:5px;
    position:fixed;
    top:0;
    left:0;
    background-color:yellow;
    font-weight:bold;
}
```


## Edit a book
Start `book/edit.blade.php` by copying `book/create.blade.php`.

In order to edit a book, we need to know *which* book to edit.

Update edit route to use `{id}` rather than `{title}`

Hide the id in the form as a hidden field.
```php
<input type='hidden' name='id' value='{{ $book->id }}'>
```

That way when the form is submitted, the controller action can retrieve the book id to know which book to edit:
```php
$book = Book::find($id);
return view('books.edit')->with('book', $book);
```

Test it with ids 1,2,3, etc.

Add links from individual book page.

Handle a bad id:
```php
if(is_null($book)) {
    $request->session()->flash('message', 'Book not found');
    return redirect('/books');
}
```

Do the edit:
```php
$book = Book::find($request->id);

$book->title = $request->title;
$book->cover = $request->cover;
$book->published = $request->published;
$book->purchase_link = $request->purchase_link;

$book->save();

return 'Book was saved'.
```


Better return:
```php
$request->session()->flash('message', 'Your changes were saved');
return redirect('/books/edit/'.$request->id);
```


## Delete a book
Try this one on your own. I'll share an example solution next week.
