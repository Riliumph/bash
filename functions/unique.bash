unique()
{
  local filepath="$1"
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi
  # main process
  # Attention to how to escape single-quotation
  local -r AWK_DEDUP='!dictionary[$0]++'
  # Need not sort -f unlike uniq command
  awk "$AWK_DEDUP" "$filepath"
}
