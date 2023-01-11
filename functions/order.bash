asc_order()
{
  declare argv
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    mapfile -t argv < <(cat -)
  else
    mapfile -t argv < "$1"
  fi
  # Check tool
  declare tool
  if type sort &> /dev/null; then
    tool='sort -f'
  else
    echo "Cannot find sorting tool"
    exit 1
  fi
  # main process
  printf "%s\n" "${argv[@]}" | eval "${tool}"
}

reverse_order()
{
  declare argv
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    # -t: remove LF
    mapfile -t argv < <(cat -) # -: stdin
  else
    mapfile -t argv < "$1"
  fi
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
  printf "%s\n" "${argv[@]}" | eval "${tool}"
}
