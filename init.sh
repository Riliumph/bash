#################### ATTENTION ###################
# It prohibits using "set -u" to detect that a variable is undefined.
# It is only allowed for shell scripts with execution privileges.
# set -u   Don't allow here

if [[ ! -v BASH_ROOT ]];then
	echo '$BASH_ROOT is undefined!!'
	return 1
fi

