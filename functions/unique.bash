unique()
{
  local filepath="$1"
  local lines
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    filepath="/dev/stdin"
  fi
  # -t: remove LF
  mapfile -t lines < "$filepath"
  # main process
  # Attention to how to escape single-quotation
  uniq='awk '\''!dictionary[$0]++'\'
  # Need not sort -f unlike uniq command
  printf "%s\n" "${lines[@]}" | eval "${uniq}"
}
