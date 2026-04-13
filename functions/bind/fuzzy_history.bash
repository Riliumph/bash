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

  local -r CMD=$(fc -ln \
    | trim \
    | reverse \
    | unique \
    | peco --query "${READLINE_LINE}")
  READLINE_LINE=${CMD}   # Input to terminal's readline
  READLINE_POINT=${#CMD} # Set cursor
}

