# Attention: No need bind's option "-x"
# Ctrl+Up-Arrow : Move parent directory
if [[ ${PS1} ]]; then
  # \er : redraw PS1 @ GNU readline
  # \e[1;5A : Ctrl-Up
  bind '"\e[1;5A":"\e[3;5~\ercd ../\n"'
  # \e[1;3A : Alt-Up
  bind '"\e[1;3A":"\e[3;5~\ercd ../\n"'
fi

# Alt+Down: Select the destination
if type peco &> /dev/null; then
  bind '"\e[1;3B":"\ercd\n"'
fi

