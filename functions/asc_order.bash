asc_order()
{
  local argv=$@
  if [ -p /dev/stdin ]; then
    if [ "${argv}" == "" ]; then 
      argv=$(cat -)
    fi
  fi
  echo "${argv}" | sort -f
}
