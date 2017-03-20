#!/bin/bash

# gitarc.sh
# made by Adam Cotner, but I guess you can use it
# just give me some credit or something

PULL_PUSH=false
CONTINUOUS_INPUT=false

main() {	
	# collect the flags and strip them from the arguments
	while getopts "pc" o; do
	    case "${o}" in
	        p)
	            PULL_PUSH=true
	            ;;
	        c)
	            CONTINUOUS_INPUT=true
	            ;;
	        *)
	            usage
	            exit 1;
	            ;;
	    esac
	done
	shift $((OPTIND-1))

	# if you supply more than one non-flag argument, usage
	# if you supply 0 arguments and NO -c flag, usage
	if [ $# -gt 1 ] || ([ $# -eq 0 ] && ! $CONTINUOUS_INPUT)
		then
		usage
		exit 1;
	fi

	# if you supply one argument, commit once
	if [ $# -eq 1 ]
		then
		command_sequence "$1"
	fi

	if ${CONTINUOUS_INPUT}
		then
		cont_usage
		while true; do
			read -p "commit message>" message

			if [ "$message" == "" ]
				then
				exit 0;
			fi

			command_sequence "$message"
		done
	fi
}

command_sequence() {

	# add all new, updated, and deleted files
	git add .
	git add -u

	# commit
	git commit -m "$1"

	# check if you're supposed to pull/push
	if [ ${PULL_PUSH} ]
		then
			pull_push
	fi
}

pull_push() {

	# get branch name
	BRANCH=$(git branch | awk '/\*/ { print $2; }')

	# pull before you push
	git pull origin "$BRANCH"

	# push
	git push origin "$BRANCH"
}

#usage information
usage() {
	echo "~~ git-add-remove-commit usage: ~~"
	echo ""
	echo "general:"
	echo "please supply exactly one commit message, unless you"
	echo "use the '-c' flag as explained below."
	echo ""
	echo "flags:"
	echo "-p: activates pulling/pushing on the active branch."
	echo "-c: activates continuous input. this allows the"
	echo "      user to supply commit messages without having"
	echo "      to restart the script."
	echo ""
	echo "~~ ~~"
}

# continuous input information
cont_usage() {
	echo ""
	echo ""
	echo "Continuous Input activated!"
	echo "...press <enter> with no message to exit."
	echo ""
	echo ""
}

# go!
main "$@"