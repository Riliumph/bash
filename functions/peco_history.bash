###
# PecoHistory
#
# search bash_history by peco
# 1.Reverse order to reverse the time series
# 2.Trim the line number
# 3.Trim the duplication in history
# 4.Pipe to peco
PecoHistory()
{
  local sed_flag
  local trim_line_number

  case "${PF}" in
    MacOS) sed_flag='-E' ;;
    *)     sed_flag='-r' ;;
  esac
  trim_line_number='s/^[[:space:]]*[0-9]+[[:space:]]+//'
  local -r CMD=$(\history \
    | reverse \
    | sed "${sed_flag}" "${trim_line_number}" \
    | unique \
    | peco --query "${READLINE_LINE}")
  READLINE_LINE=${CMD}   # Input to terminal's readline
  READLINE_POINT=${#CMD} # Set cursor
}

if command -v peco &> /dev/null; then
  bind -x '"\C-r": PecoHistory'
fi
