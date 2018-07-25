################## ATTENTION ###################
# It prohibits using "set -u" to detect that a variable is undefined.
# It is only allowed for.bashell scripts with execution privileges.
# set -u   Don't allow here

if [[ ! -v BASH_ROOT ]];then
  echo '$BASH_ROOT is undefined!!'
  return 1
fi

# bash secret power
shopt -s expand_aliases    # for non-interactive shell
shopt -s cdspell           # estimate spell miss
shopt -s dirspell          # complement by ignorring upper & lower case
shopt -s extglob
shopt -s globstar

### readline config
INPUTRC="$BASH_ROOT/readline.inputrc"

### Function definition
source "$BASH_ROOT/functions/date_time.bash"
source "$BASH_ROOT/functions/seds.bash"

### Bash options
source "$BASH_ROOT/scripts/env.bash"
source "$BASH_ROOT/scripts/alias.bash"
source "$BASH_ROOT/scripts/prompt.bash"
source "$BASH_ROOT/scripts/completion.bash"

### Use alias
source "$BASH_ROOT/functions/cd.bash"
if which peco &> /dev/null; then
  source "$BASH_ROOT/functions/peco_history.bash"
fi

### Use other setting
source "$BASH_ROOT/scripts/bind.bash"

