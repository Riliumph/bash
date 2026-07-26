unique()
{
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: unique [FILE]" \
      "" \
      "Remove duplicate lines while preserving order." \
      "" \
      "Input:" \
      "  FILE    Read from file." \
      "  stdin   Read from standard input."
    return 0
  fi

  local filepath="$1"
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    # e.g. echo xxx | unique
    filepath="/dev/stdin"
  fi

  if [ -z "$filepath" ]; then
    # e.g. unique / unique < xxx.txt
    if [ -t 0 ]; then
      # Attention: awk keeps reading input until it reaches EOF (stdin is closed).
      echo "unique: waiting your input... exit: Ctrl-D" >&2
    fi
    filepath="/dev/stdin"
  fi
  local -r AWK_DEDUP='!dictionary[$0]++'
  # Need not sort -f unlike uniq command
  awk "$AWK_DEDUP" "$filepath"
}
