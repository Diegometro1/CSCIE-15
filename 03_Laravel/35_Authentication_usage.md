__Bonus material__

Integrating authentication into Project 4 is optional and this information will not be addressed in any of the progress log quick check questions.


## Auth::check()
With the mechanisms for authorization in place you can now adapt your application to do different things based on whether the visitor is logged in or not.

To demonstrate this, we're now going to shift Foobooks so its features are only accessible to logged in users.

So if the visitor is *not* logged in, they should see these links:
+ Register
+ Login

If the visitor *is* logged in they should these links:
+ Trivia
+ Books
+ Add a Book
+ Search
+ Practice
+ Logout

To accomplish this, we'll use the __`Auth::check()`__ method which returns `True` if the user is logged in or `False` if they are not.

Study the full code of `resources/views/modules/nav.blade.php` to see how the navigation is adapted for users vs. guests:

```php
@php
    # Define a PHP array of links and their labels
    # Quite a bit of straight PHP code here, but arguably ok
    # because it's display specific and allows you to edit the link
    # labels without having to edit a logic file.
    if(Auth::check()) {
        $nav = [
            'trivia' => 'Trivia',
            'book' => 'Books',
            'book/create' => 'Add a book',
            'search' => 'Search',
            'practice' => 'Practice',
        ];
    } else {
        $nav = [
            'register' => 'Register',
            'login' => 'Login',
        ];
    }
@endphp

<nav>
    <ul>
        @foreach($nav as $link => $label)
            <li><a href='/{{ $link }}' class='{{ Request::is($link) ? 'active' : '' }}'>{{ $label }}</a>
        @endforeach

        @if(Auth::check())
            <li>
                <form method='POST' id='logout' action='/logout'>
                    {{csrf_field()}}
                    <a href='#' onClick='document.getElementById("logout").submit();'>Logout</a>
                </form>
            </li>
        @endif
    </ul>
</nav>
```




## Restricting routes with middleware
One of the purposes of authentication is to keep non-registered visitors away from certain routes.

One way this can be accomplished is using [middleware](http://laravel.com/docs/middleware) which lets you filter requests entering your application. (Earlier, we saw an example of middleware with the CSRF checking that happens when forms are submitted.)

Laravel ships with a default middleware file for authentication (`Illuminate\Auth\Middleware\Authenticate`). When this filter is used, a check is done to see if a visitor is authenticated, and if not they're redirected to the login page.

To understand how this middleware is used, open `/app/Http/Kernel.php` and note that it's part of the `$routeMiddleWare` array with the key `auth`:
```php
protected $routeMiddleware = [
    'auth' => \App\Http\Middleware\Authenticate::class,
    'auth.basic' => \Illuminate\Auth\Middleware\AuthenticateWithBasicAuth::class,
    'guest' => \App\Http\Middleware\RedirectIfAuthenticated::class,
    'throttle' => \Illuminate\Routing\Middleware\ThrottleRequests::class,
];
```

Knowing this, we'll adapt a route to use this middleware.

For example, here's the existing route to view the *Add a book* page:

```php
Route::get('/book/create', 'BookController@create');
```

Update this route to look like this:
```php
Route::get('/book/create', [
    'middleware' => 'auth',
    'uses' => 'BookController@create'
]);
```

Now, when `/book/create` is visited, the `auth` middleware will apply.

__Test it out:__

If you are not logged in and you attempt to visit `http://localhost/book/create` you should be redirected to the login page.

Then, if you successfully login, you'll be sent back to `http://localhost/book/create`.



## Restricting multiple routes with Middleware
In the above example, we restricted a single route, but you can also restrict many routes using a route group like this:

```php
Route::group(['middleware' => 'auth'], function () {
    # Create a book
    Route::get('/book/create', 'BookController@create');
    Route::post('/book', 'BookController@store');

    # Edit a book
    Route::get('/book/{id}/edit', 'BookController@edit');
    Route::put('/book/{id}', 'BookController@update');

    # Delete a book
    Route::get('/book/{id}/delete', 'BookController@delete');
    Route::delete('/book/{id}', 'BookController@destroy');

    # View all books
    Route::get('/book', 'BookController@index');

    # View a book
    Route::get('/book/{id}', 'BookController@show');

    # Search all books
    Route::get('/search', 'BookController@search');
});
```


## Making the user data available to many or all views
It's common to want the logged-in user's data available to many or all views. For example, if you had a nav/menu bar, you may want a link to the user's profile or settings on every page.

One way to do this is to make sure every time you return a view, you include `$user` as part of the data:

```php
return view('x')->with(['user' => $user]);
```

However, if *every* page needs this info, this makes for a lot of repeat code. A better approach is to find a way to make this data &ldquo;universally&rdquo; available.

There's several different ways you accomplish this task, but we'll use a [view composer](https://laravel.com/docs/5.5/views#view-composers).

> &ldquo;View composers are callbacks or class methods that are called when a view is rendered. If you have data that you want to be bound to a view each time that view is rendered, a view composer can help you organize that logic into a single location.&rdquo;

To demonstrate this, we'll make it so that the "logout" button in the nav bar includes the logged in user's name.

Start by creating a new class called `ViewServiceProvider.php` in `app/Providers` with the following code:

```php
<?php

namespace App\Providers;

use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class ViewServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     * @return void
     */
    public function boot()
    {
        # This view composer will make the data available for the `layouts.master` view, which
        # includes the `modules.nav` view where we want to use this data.
        view()->composer('layouts.master', function ($view) {
            $user = request()->user();
            $view->with('user', $user);
        });
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
```

Then in `config/app.php` register this new provider by adding the line `App\Providers\ViewServiceProvider::class,` to the end of the `providers` array.

```php
    'providers' => [

        # [...]

        /*
         * Application Service Providers...
         */
        App\Providers\AppServiceProvider::class,
        App\Providers\AuthServiceProvider::class,
        // App\Providers\BroadcastServiceProvider::class,
        App\Providers\EventServiceProvider::class,
        App\Providers\RouteServiceProvider::class,
        App\Providers\ViewServiceProvider::class, # <-- NEW
    ],

],
```

Your master and nav views should now have access to a variable `$user`. Here's an example showing usage of that variable as part of the logout link from the nav:

```php
<li>
    <form method='POST' id='logout' action='/logout'>
        {{ csrf_field() }}
        <a href='#' onClick='document.getElementById("logout").submit();'>Logout {{ $user->name }}</a>
    </form>
</li>
```


## Reference
+ [Docs: Authentication](http://laravel.com/docs/authentication)
+ [Docs: Middleware](http://laravel.com/docs/middleware)
