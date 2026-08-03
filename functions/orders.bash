asc()
{
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: asc [FILE]" \
      "" \
      "Sort lines alphabetically (case-insensitive)." \
      "" \
      "Arguments:" \
      "  FILE    input file (default: stdin)"
    return 0
  fi

  local filepath="$1"

  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi

  if [ -z "$filepath" ]; then
    if [ -t 0 ]; then
      echo "asc: waiting your input... exit: Ctrl-D" >&2
    fi
    filepath="/dev/stdin"
  fi

  # Check tool
  if ! command -v sort &> /dev/null; then
    echo "asc: sort command not found" >&2
    return 1
  fi

  sort -f < "$filepath"
}

reverse()
{
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: asc [FILE]" \
      "" \
      "Sort input lines alphabetically." \
      "If FILE is omitted, read from stdin."
    return 0
  fi

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
