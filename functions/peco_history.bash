###
# peco_history
#
# search bash_history by peco
# bind Ctrl + r
# 1.Reverse order to reverse the time series
# 2.Trim the line number
# 3.Trim the duplication in history
# 4.Pipe to peco
peco_history()
{
  local descending_order
  if which sort &> /dev/null; then
    descending_order='sort -r'
  elif which tac &> /dev/null; then
    descending_order='tac'
  else
    descending_order='tail -r'
  fi
  local trim_line_number='sed -re "s/^\s+[0-9]+\s+//"'
  local trim_duplication='awk '\''!dictionaty[$0]++'\'''
  local CMD=$(\history \
              | eval $descending_order \
              | eval $trim_line_number \
              | eval $trim_duplication \
              | peco --query "${READLINE_LINE}")
  READLINE_LINE="${CMD}"  # Input to terminal's readline
  READLINE_POINT=${#CMD}  # Set cursor
}

bind -x '"\C-r": peco_history'

