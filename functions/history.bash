SyncHistory()
{
  history -a   # append commands from this session to the HISTFILE
  history -n   # read commands added by other sessions from the HISTFILE
}

###
# CleanHistory
# Clean bash's command history
CleanHistory()
{
  local -r OLD_IFS="${IFS}"
  IFS=$'\n' # support command history with half-width space
  trap 'IFS=$OLD_IFS' RETURN
  # Read history file
  mapfile -t uniq_ary < <(reverse "${HISTFILE}" | trim | unique | reverse)
  \cp "${HISTFILE}" "${HISTFILE}.bak" &> /dev/null
  echo "${uniq_ary[*]}" > "${HISTFILE}"
}

###
# CleanCdHistory
# Clean cd's history
CleanCdHistory()
{
  local -r OLD_IFS="${IFS}"
  IFS=$'\n' # support path with half-width space
  trap 'IFS=$OLD_IFS' RETURN
  # Read history file
  mapfile -t uniq_ary < <(reverse "${CD_HISTORY}" | unique | reverse)
  \cp "${CD_HISTORY}" "${CD_HISTORY}.bak" &> /dev/null
  : > "${CD_HISTORY}" # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e ${line} ]]; then
      echo "${line}" >> "${CD_HISTORY}"
    fi
  done
}
