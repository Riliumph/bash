reverse()
{
  local filepath="$1"
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi

  if [ -z "$filepath" ]; then
    if [ -t 0 ]; then
      echo "reverse: waiting your input... exit: Ctrl-D" >&2
    fi
    filepath="/dev/stdin"
  fi

  # Check tool
  local tool=() # option needs array
  if command -v tac &> /dev/null; then
    tool=("tac")
  elif command -v tail &> /dev/null; then
    tool=("tail" "-r")
  else
    echo "reverse: no reverse tool found (need 'tac' or 'tail -r')" >&2
    return 1
  fi

  "${tool[@]}" < "$filepath"
}
