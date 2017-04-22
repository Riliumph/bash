#################### ATTENTION ###################
# It prohibits using "set -u" to detect that a variable is undefined.
# It is only allowed for shell scripts with execution privileges.
# set -u   Don't allow here

if [[ ! -v BASH_ROOT ]];then
	echo '$BASH_ROOT is undefined!!'
	return 1
fi

### readline config
INPUTRC="${BASH_ROOT}/readline.inputrc"

### Bash options
source "${BASH_ROOT}/bash.sh"
source "${BASH_ROOT}/scripts/alias.sh"
source "${BASH_ROOT}/scripts/prompt.sh"
source "${BASH_ROOT}/scripts/completion.sh"

source "${BASH_ROOT}/functions/cd.sh"
