########## ATTENTION ##########
# It prohibits using "set -u" to detect that a variable is undefined.
# It is only allowed for.bashell scripts with execution privileges.
# set -u   Don't allow here

if [[ ! -t 1 ]];then
  echo "Cannot use stdout(fd 1)"
  # Do not exe to avoid following error in scp
  # bind: warning: line editing not enabled
  return;
fi

if [[ ! -v BASH_ROOT ]];then
  echo '$BASH_ROOT is undefined!!'
  return 1
fi

### bash secret power
shopt -s expand_aliases    # for non-interactive shell
shopt -s cdspell           # estimate spell miss
shopt -s dirspell          # complement by ignorring upper & lower case
shopt -s extglob
shopt -s globstar

### Global variable
source "$BASH_ROOT/conf.d/env.bash"
source "$BASH_ROOT/conf.d/cache.bash"
source "$BASH_ROOT/conf.d/global.bash"
source "$BASH_ROOT/conf.d/history.bash"
source "$BASH_ROOT/conf.d/prompt.bash"
source "$BASH_ROOT/conf.d/completion.bash"

### readline config
INPUTRC="$BASH_ROOT/readline/${OS,,}.inputrc"

### LS_COLOR config
if type dircolors &> /dev/null; then
  COLORRC="$BASH_ROOT/conf.d/${OS,,}.colorrc"
  eval $(dircolors "${COLORRC}")
fi

### Function definition
source "$BASH_ROOT/functions/date_time.bash"
source "$BASH_ROOT/functions/order.bash"
source "$BASH_ROOT/functions/path.bash"
source "$BASH_ROOT/functions/seds.bash"
source "$BASH_ROOT/functions/unique.bash"

### Bash options
source "$BASH_ROOT/scripts/alias/${OS,,}.bash"

### Use alias
source "$BASH_ROOT/functions/cd.bash"
if which peco &> /dev/null; then
  source "$BASH_ROOT/functions/peco_history.bash"
fi

### Use other setting
source "$BASH_ROOT/scripts/bind/${OS,,}.bash"

