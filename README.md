# gitaddremotecommit
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
git add -u
git commit -m "apparently i also deleted shit"
git push origin master
```
becomes
```
git <alias> this is a commit message!
```
### Setup
##### Add your alias to `.gitconfig`
like so:
```
...
[alias]
    <your_alias> = "!fn(){ ~/path/to/gitaddremovecommit.sh \"$@\"; }; fn"
```
to explain:
- `<your_alias>` can be anything you think fits its function. I like `arc`
- `!` tells git that you're attempting to run an external command, rather than a native git command
- `fn(){ ... }; fn;` just wraps the actual script in a function, then calls it. This allows you to pass arguments down to the script.
- `.../gitaddremovecommit.sh \"$@\";` runs the script and passes all your arguments to it

### Usage
Example:

Given path `~/code/scripts/gitaddremovecommit.sh` and alias `arc`, I just type:
```
git arc fixed that pesky bug
```
...and I've added, commited, and pushed my most recent changes with commet message "fixed that pesky bug"
