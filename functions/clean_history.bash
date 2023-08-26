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
  : > "${HISTFILE}" # truncate file
  for line in "${uniq_ary[@]}"; do
    echo "${line}" >> "${HISTFILE}"
  done
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
