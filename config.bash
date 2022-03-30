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

### Function definition
# Don't execute function yet
func_definitions=($(find "$BASH_ROOT/functions" -name "*.bash" -type f))
for func_definition in "${func_definitions[@]}"; do
  source ${func_definition}
done

### Config bash
configs=($(find "$BASH_ROOT/conf.d" -name "*.bash" -type f))
for config in "${configs[@]}"; do
  source ${config}
done

### Config readline
INPUTRC="$BASH_ROOT/readline/${PF,,}.inputrc"

### Config LS_COLOR
if type dircolors &> /dev/null; then
  COLORRC="$BASH_ROOT/conf.d/${PF,,}.colorrc"
  eval $(dircolors "${COLORRC}")
fi

### Config by environment
source "$BASH_ROOT/alias/${PF,,}.bash"
source "$BASH_ROOT/bind/${PF,,}.bash"

# Execute
CleanHistory
CleanCdHistory
