### Check Requirement
source "$BASH_ROOT/conf.d/require.bash"
if [[ $? != 0 ]]; then
  return 1
fi

### Function definition
# Don't execute function yet
func_definitions=($(find "$BASH_ROOT/functions" -name "*.bash" -type f))
for func_definition in "${func_definitions[@]}"; do
  source ${func_definition}
done

### Config bash
configs=($(find "$BASH_ROOT/conf.d" -name "*.bash" -type f | grep -v "env.sh"))
for config in "${configs[@]}"; do
  source ${config}
done

### Config readline
INPUTRC="$BASH_ROOT/readline/${PF,,}.inputrc"

### Config LS_COLOR
if type dircolors &> /dev/null; then
  COLORRC="$BASH_ROOT/conf.d/${PF,,}.colorrc"
  if [ -e ${COLORRC} ];then
    eval $(dircolors "${COLORRC}")
  fi
fi

### Config by environment
source "$BASH_ROOT/alias/${PF,,}.bash" &> /dev/null
source "$BASH_ROOT/bind/${PF,,}.bash" &> /dev/null

# Execute
CleanHistory
CleanCdHistory
