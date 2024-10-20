asc_order()
{
  local filepath="$1"
  local lines
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi
  # -t: remove LF
  mapfile -t lines < "$filepath"
  # Check tool
  declare tool
  if type sort &> /dev/null; then
    tool='sort -f'
  else
    echo "Cannot find sorting tool"
    exit 1
  fi
  # main process
  printf "%s\n" "${lines[@]}" | eval "${tool}"
}

reverse_order()
{
  local filepath="$1"
  local lines
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi
  # -t: remove LF
  mapfile -t lines < "$filepath"
  # Check tool
  declare tool
  if type tac &> /dev/null; then
    tool='tac'
  elif type tail &> /dev/null; then
    tool='tail -r'
  else
    echo "Cannot find ordering tool"
    exit 1
  fi
  # main process
  # "\n": attach LF for reverse tool
  printf "%s\n" "${lines[@]}" | eval "${tool}"
}
