#!/bin/bash
# gitaddremovecommit adds, removes, and commits all changes with a default message

main() {	
	# hints if you supply less or more than one argument
	if [ $# -ne 1 ]
		then
			echo $#
			print_usage
			exit 1 
	fi

	# add all new, updated, and deleted files
	git add .
	git add -u

	# commit
	git commit -m "$1"
}

#usage information
print_usage() {
	echo "~~ gitaddremovecommit usage: ~~"
	echo "- Please supply a commit message. If your message contains a <space>, please encase the whole message in double quotes."
	echo "~~ ~~"
}

# go!
main "$@"