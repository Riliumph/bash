SyncHistory()
{
  history -a # append commands from this session to the HISTFILE
  history -n # read commands added by other sessions from the HISTFILE
}

###
# CleanHistory
# Clean bash's command history
CleanHistory()
{
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: CleanHistory" \
      "" \
      "Clean bash command history." \
      "" \
      "Actions:" \
      "  - Remove duplicated and empty history entries." \
      "  - Create backup file: \${HISTFILE}.bak"
    return 0
  fi

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
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: CleanCdHistory" \
      "" \
      "Clean cd history." \
      "" \
      "Actions:" \
      "  - Remove duplicated paths." \
      "  - Remove paths that no longer exist." \
      "  - Create backup file: \${CD_HISTORY}.bak"
    return 0
  fi

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
