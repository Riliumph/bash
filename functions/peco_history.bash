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
  local reverse_order
  if which tac &> /dev/null; then
    reverse_order='tac'
  else
    reverse_order='tail -r'
  fi
  local trim_line_number
  if [[ ${OS} = 'MacOS' ]]; then
    trim_line_number='sed -Ee "s/^ +[0-9]+ +//"'
  else
    trim_line_number='sed -re "s/^\s+[0-9]+\s+//"'
  fi
  local trim_duplication='awk '\''!dictionaty[$0]++'\'''
  local CMD=$(\history \
              | eval $reverse_order \
              | eval $trim_line_number \
              | eval $trim_duplication \
              | peco --query "${READLINE_LINE}")
  READLINE_LINE="${CMD}"  # Input to terminal's readline
  READLINE_POINT=${#CMD}  # Set cursor
}

bind -x '"\C-r": peco_history'

