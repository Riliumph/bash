asc()
{
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
