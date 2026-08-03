# DEBUG flag
# set -x
# export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

### Check Requirement
BASH_CONFD="$BASH_ROOT/conf.d"
if ! source "$BASH_CONFD/require.bash"; then
  return 1
fi

### Function definition
# Don't execute function yet
mapfile -d $'\0' func_definitions < <(find "$BASH_ROOT/functions" -name "*.bash" -type f -print0)
for func_definition in "${func_definitions[@]}"; do
  # echo "source ${func_definition}"
  source "${func_definition}"
done

if ! IsAvailable; then
  return 1
fi

### Config
# bash
source "$BASH_CONFD/shelloption.bash"
source "$BASH_CONFD/stty.bash"
source "$BASH_CONFD/completion.bash"
source "$BASH_CONFD/global.bash"
source "$BASH_CONFD/lang.bash"
source "$BASH_CONFD/path.bash"
source "$BASH_CONFD/git.bash"
source "$BASH_CONFD/prompt.bash"
source "$BASH_CONFD/cache.bash"
source "$BASH_CONFD/history.bash"
# readline
INPUTRC="$BASH_ROOT/readline/${PF,,}.inputrc"
# LS_COLOR
if command -v dircolors &> /dev/null; then
  COLORRC="$BASH_CONFD/${PF,,}.colorrc"
  if [ -e "${COLORRC}" ]; then
    eval "$(dircolors "${COLORRC}")"
  fi
fi

### Config by environment
source "$BASH_ROOT/alias/${PF,,}.bash"
source "$BASH_ROOT/bind/${PF,,}.bash"

# Execute
CleanCdHistory
