###
# peco_history
#
# search bash_history by peco
# 1.Reverse order to reverse the time series
# 2.Trim the line number
# 3.Trim the duplication in history
# 4.Pipe to peco
peco_history()
{
  local trim_line_number
  if [[ ${OS} == 'MacOS' ]]; then
    trim_line_number='sed -Ee "s/^ +[0-9]+ +//"'
  else
    trim_line_number='sed -re "s/^\s+[0-9]+\s+//"'
  fi
  local CMD=$(\history \
              | reverse_order \
              | eval ${trim_line_number} \
              | unique \
              | peco --query "${READLINE_LINE}")
  READLINE_LINE="${CMD}"  # Input to terminal's readline
  READLINE_POINT=${#CMD}  # Set cursor
}

if which peco &> /dev/null; then
  bind -x '"\C-r": peco_history'
fi
