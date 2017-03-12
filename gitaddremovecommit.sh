#!/bin/bash
# gitaddremovecommit adds, removes, and commits all changes with a default message

main() {	
	# hints if you supply less or more than one argument
	if [ $# -eq 0 ]
		then
			print_general_usage
			exit 1 
	fi

	if [ $1 -eq "-branch" ]
		then
			if [ $# -ne 2 ]
				then
					print_branch_usage
					exit 1
				else
					# change the branch config
					echo "$2"
			fi		
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

	# pull before you push
	git pull origin master

	# push
	git push origin master
}

#usage information
print_general_usage() {
	echo "~~ gitaddremovecommit usage: ~~"
	echo "- Please supply a commit message."
	echo "~~ ~~"
}

print_branch_usage() {
	echo "~~ gitaddremovecommit usage: ~~"
	echo "- Please supply one branch name after '-branch'"
	echo "~~ ~~"
}

# go!
main "$@"