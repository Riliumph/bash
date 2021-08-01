asc_order()
{
  local argv=$@
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    if [ "${argv}" == "" ]; then 
      argv=$(cat -)
    fi
  fi
  # main process
  echo "${argv}" | sort -f
}

reverse_order()
{
  local argv=$@
  # Check Pipeline
  if [ -p /dev/stdin ]; then
    if [ "${argv}" == "" ]; then 
      argv=$(cat -)
    fi
  fi
  # Check tool
  local tool=""
  if type tac &> /dev/null; then
    tool='tac'
  elif type tail &> /dev/null; then
    tool='tail -r'
  else
    echo "Cannot find ordering tool"
    exit 1
  fi
  # main process
  echo "${argv}" | eval ${tool}
}
