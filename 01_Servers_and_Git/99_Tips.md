# Tips

## Hard Resetting - &ldquo;Pull in case of emergencies&rdquo;
If you ever find yourself backed into a corner with lots of merges and conflicts you're having a hard time resolving, there's a solution which will update your working repository to match your repository on Github.

**Warning: this will overwrite any changes you might have had in your working repository.** Given this, you only want to do this in situations where you're okay with losing any changes in your working repository.

The most common scenario for this is when your know your Github repository has the code exactly as you want it, but your local or live repository got messed up with changes you don't actually want to make.

Warning aside, on to the commands:

```bash
$ git fetch --all
$ git reset --hard origin/master
```

(replace `origin` with the name of your remote)

`git fetch` downloads the latest from remote without trying to merge.

`git reset` resets the master branch to what you just fetched.

Read more: [How to undo (almost) anything with Git](https://github.com/blog/2019-how-to-undo-almost-anything-with-git)


## Git: Ignore a file that's already in the repo
```bash
$ git update-index --assume-unchanged name_of_file.txt
```


## Is this directory a repo?
You can tell if a directory has been set up as a repo because it will have a `.git` folder in it.

Use the `ls -la` command to see the contents of a directory, including hidden files (which the `.git` folder is).

Alternatively, you can run the `git status` command and it will let you know if the current directory is or isn't a repo.
