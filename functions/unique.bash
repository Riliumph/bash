unique()
{
  local argv=$@
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    if [[ "${argv}" == "" ]]; then
      argv=$(cat -)
    fi
  fi
  # main process
  # Attention to how to escape single-quotation
  # Need not sort -f unlike uniq command
  uniq='awk '\''!dictionary[$0]++'\'''
  if type eval &> /dev/null; then
    echo "${argv}" | eval "${uniq}"
  else
    echo "${argv}" | awk '!dictionary[$0]++'
  fi
}
