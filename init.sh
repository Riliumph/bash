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

### Function definition
source "${BASH_ROOT}/functions/date_time.sh"
source "${BASH_ROOT}/functions/seds.sh"

### Bash options
source "${BASH_ROOT}/bash.sh"
source "${BASH_ROOT}/scripts/alias.sh"
source "${BASH_ROOT}/scripts/prompt.sh"
source "${BASH_ROOT}/scripts/completion.sh"

### Use alias
source "${BASH_ROOT}/functions/cd.sh"
if which peco &> /dev/null; then
  source "${BASH_ROOT}/functions/peco_history.sh"
fi
