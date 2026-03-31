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
  local -r CMD=$(fc -ln \
    | reverse \
    | unique \
    | peco --query "${READLINE_LINE}")
  READLINE_LINE=${CMD}   # Input to terminal's readline
  READLINE_POINT=${#CMD} # Set cursor
}

