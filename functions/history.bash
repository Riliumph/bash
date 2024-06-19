ControlHistory()
{
  local -r argc="$#"
  local -r status="$@"
  if ((argc == 0)); then
    echo "Missing args"
    return 1
  elif ((1 < argc)); then
    echo "Excess args: ${argc}"
    return 1
  fi

  case ${status} in
    16) ReloadHistory ;;
    127) ReloadHistory ;;
    *) ShareHistory ;;
  esac
  return 0
}

ShareHistory()
{
  history -a # Add a previous command to bash_history
  CleanHistory
  history -c # Clear local history in terminal
  history -r # Reload history from bash_history
}

ReloadHistory()
{
  history -c
  history -r
}

###
# CleanHistory
# Clean bash's command history
CleanHistory()
{
  local -r OLD_IFS="${IFS}"
  IFS=$'\n' # support command history with half-width space
  # Read history file
  mapfile -t uniq_ary < <(reverse_order "${HISTFILE}" | remove_trailingspace | unique | reverse_order)
  \cp "${HISTFILE}" "${HISTFILE}.bak" &> /dev/null
  echo "${uniq_ary[*]}" > ${HISTFILE}
  IFS="${OLD_IFS}"
}

###
# CleanCdHistory
# Clean cd's history
CleanCdHistory()
{
  local -r OLD_IFS="${IFS}"
  IFS=$'\n' # support path with half-width space
  # Read history file
  mapfile -t uniq_ary < <(reverse_order "${CD_HISTORY}" | unique | reverse_order)
  \cp "${CD_HISTORY}" "${CD_HISTORY}.bak" &> /dev/null
  : > "${CD_HISTORY}" # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e ${line} ]]; then
      echo "${line}" >> "${CD_HISTORY}"
    fi
  done
  IFS="${OLD_IFS}"
}
