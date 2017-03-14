# gitaddremovecommit
a shell script for easier adding, removing, and commiting files with one command
_____
### Summary
Frankly, I was tired of typing `git add .`, then `git commit -m`, and likely smashing my keyboard when I realize that my `rm`ed files are not `git rm`ed. I was also mildly irritated about having to type quotes around my commit messages.

Now, this:
```
git add .
git commit -m "some changes"
git push origin master
*rage*
git pull origin master
git push origin master
*rage*
git add -u
git commit -m "apparently i also deleted shit"
git push origin master
```
becomes
```
git <alias> this is a commit message!
```
with _or_ without pulling/pushing, depending on your use of the `-p` flag.
### Setup
##### Add your alias to `.gitconfig`
like so:
```
...
[alias]
    <your_alias> = "!fn(){ ~/path/to/gitaddremovecommit.sh -p \"$@\"; }; fn"
```
to explain:
- `<your_alias>` can be anything you think fits its function. I like `arc`
- `!` tells git that you're attempting to run an external command, rather than a native git command
- `fn(){ ... }; fn;` just wraps the actual script in a function, then calls it. This allows you to pass arguments down to the script.
- `.../gitaddremovecommit.sh` is the path to the script, duh.
- `-p` tells the script to pull/push on the current branch. Leave this off if you don't want to pull/push.
- `\"$@\";` passes all the arguments to the script.

### Usage
Example:

I wish to set up aliases for `gitaddremovecommit` with _and_ without the pull/push step. So, my `.gitconfig` file looks like:
```
[alias]
	arc = "!fn(){ ~/scripts/gitaddremovecommit.sh \"$@\"; }; fn"
	arcp = "!fn(){ ~/scripts/gitaddremovecommit.sh -p \"$@\"; }; fn"
```
Now when I want to commit some changes, I just type:
```
git arc fixed that pesky bug
```
...and I've added all new/changed files, removed untracked files, and commited with message "fixed that pesky bug". If I _also_ wanted to pull/push, I'd type:
```
git arcp fixed that pesky bug
```
instead. Magic!
