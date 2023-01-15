unique()
{
  declare argv
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    mapfile -t argv < <(cat -)
  else
    mapfile -t argv < "$1"
  fi
  # main process
  # Attention to how to escape single-quotation
  uniq='awk '\''!dictionary[$0]++'\'
  # Need not sort -f unlike uniq command
  printf "%s\n" "${argv[@]}" | eval "${uniq}"
}
