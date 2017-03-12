#!/bin/bash
# gitaddremovecommit adds, removes, and commits all changes with a default message

main() {	
	# hints if you supply less or more than one argument
	if [ $# -eq 0 ]
		then
			print_general_usage
			exit 1 
	fi

	# add all new, updated, and deleted files
	git add .
	git add -u

	# build commit message
	MSG=""
	for ARG in "$@"
	do
		MSG="$MSG $ARG"
	done

	# commit
	git commit -m "$MSG"

	# get branch name
	BRANCH=$(git branch | awk '/\*/ { print $2; }')

	# pull before you push
	git pull origin "$BRANCH"

	# push
	git push origin "$BRANCH"
}

#usage information
print_general_usage() {
	echo "~~ gitaddremovecommit usage: ~~"
	echo "- Please supply a commit message."
	echo "~~ ~~"
}

# go!
main "$@"