###
# FuzzyHistory
#
# search bash_history by fuzzy filter tool e.g. peco
# this function is used by bind -x
FuzzyHistory()
{
  # only bind -x use this function
  # bind -x temporarily defined READLINE_LINE
  [[ -n ${READLINE_LINE+DEFINED} ]] || return 1
  # Store terminal's readline
  local old_line=${READLINE_LINE}
  local old_point=${READLINE_POINT}
  local cmd
  # fc display only latest 16 command by default
  cmd=$(
    fc -ln 1 \
      | trim \
      | reverse \
      | unique \
      | peco --query "$READLINE_LINE"
  )
  if [[ $? -ne 0 || -z "$cmd" ]]; then
    READLINE_LINE=${old_line}
    READLINE_POINT=${old_point}
    return
  fi

  READLINE_LINE=${cmd}
  READLINE_POINT=${#cmd}
}
