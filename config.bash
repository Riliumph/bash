### Check Requirement
if ! source "$BASH_ROOT/conf.d/require.bash"; then
  return 1
fi

### Function definition
# Don't execute function yet
mapfile -d $'\0' func_definitions < <(find "$BASH_ROOT/functions" -name "*.bash" -type f -print0)
for func_definition in "${func_definitions[@]}"; do
  # echo "source ${func_definition}"
  source "${func_definition}"
done

### Config
# bash
source $BASH_ROOT/conf.d/shelloption.bash
source $BASH_ROOT/conf.d/stty.bash
source $BASH_ROOT/conf.d/completion.bash
source $BASH_ROOT/conf.d/global.bash
source $BASH_ROOT/conf.d/lang.bash
source $BASH_ROOT/conf.d/path.bash
source $BASH_ROOT/conf.d/prompt.bash
source $BASH_ROOT/conf.d/cache.bash
source $BASH_ROOT/conf.d/history.bash
# readline
INPUTRC="$BASH_ROOT/readline/${PF,,}.inputrc"
# LS_COLOR
if type dircolors &> /dev/null; then
  COLORRC="$BASH_ROOT/conf.d/${PF,,}.colorrc"
  if [ -e "${COLORRC}" ]; then
    eval "$(dircolors "${COLORRC}")"
  fi
fi

### Config by environment
source "$BASH_ROOT/alias/${PF,,}.bash" &> /dev/null
source "$BASH_ROOT/bind/${PF,,}.bash" &> /dev/null

# Execute
CleanCdHistory
