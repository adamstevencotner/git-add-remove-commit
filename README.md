# git-add-remove-commit
a shell script for easier adding, removing, and commiting files with one command

_now with continuous input!_
_____
### Summary
Frankly, I was tired of typing `git add .`, then `git commit -m`, and likely smashing my keyboard when I realize that my `rm`ed files are not `git rm`ed.

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
git <alias> "this is a commit message"
```
with _or_ without pulling/pushing, depending on your use of the `-p` flag.

If you activate continuous input with the `-c` flag, this process will repeat indefinitely every time you enter a commit message, so you don't have to retype `git <alias>`. See [Usage](#usage)
### Setup
##### Add your alias to `.gitconfig`
like so:
```
...
[alias]
    <your_alias> = "!fn(){ ~/path/to/gitarc.sh <permanent_flags> \"$@\"; }; fn"
```
to explain:
- `<your_alias>` can be anything you think fits its function. I like `arc`.
- `!` tells git that you're attempting to run an external command, rather than a native git command.
- `fn(){ ... }; fn;` just wraps the actual script in a function, then calls it. This allows you to pass arguments down to the script.
- `.../gitaddremovecommit.sh` is the path to the script, duh.
- `<permanent_flags>` will be run with the script every time you use the alias. Could be any (or none) of the available flags.
- `\"$@\";` passes all the arguments to the script.

### Usage
##### General
The script takes exactly one non-flag argument: the commit message. If you wish to activate continuous input with the `-c` flag, you may optionally put in zero non-flag arguments.
##### Flags
- `-p` will turn on pulling and pushing. The script with assume you want to pull/push on the current branch.
- `-c` turns on continuous input. With it, you can just type a commit message whenever you'd like to add, remove, and commit (and pull/push with the `-p` flag). To exit, just press `<enter>` without a commit message.
##### Examples
I wish to set up aliases for `git-add-remove-commit` with _and_ without the pull/push step, as well as one with continuous input. So, my `.gitconfig` file looks like:
```
[alias]
	arc = "!fn(){ ~/scripts/gitarc.sh \"$@\"; }; fn"
	arcp = "!fn(){ ~/scripts/gitarc.sh -p \"$@\"; }; fn"
	arcpc = "!fn(){ ~/scripts/gitarc.sh -p -c \"$@\"; }; fn"
```
Now when I want to commit some changes, I just type:
```
git arc "fixed that pesky bug"
```
...and I've added all new/changed files, removed untracked files, and commited with message "fixed that pesky bug". If I _also_ wanted to pull/push, I'd type:
```
git arcp "fixed that pesky bug"
```
Finally, if I wanted to do all of the above over and over again without retyping `git arc`, my output might look like:
```
git arcpc
commit message> first commit message
[... git output ...]
commit message> second commit message
[... git output ...]
commit message>
[back to the console]
```
Magic!

Please note that `commit message>` is output from the script. You do not have to type that in!
### Hints and Gotchas
There aren't many, but here are some helpful hints to avoid frustration:
- Bash has some special characters (`;`, `!`, etc.) that don't play nice with the script. It behooves you to escape those with a backslash (ie- `commit message\!` instead of `commit message!`).
- Obviously, none of this will  work if you don't set up git first. The errors won't be pretty, and I can't help you.
- I recommend setting up some kind of credential store so that you don't have to retype your user/password. This script does not help you there.
- Passing flags into git aliases is effective. Meaning, in the above example, `git arcpc` and `git arc -p -c` would have the same effect.
