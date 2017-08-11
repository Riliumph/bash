# Ctrl+Up-Arrow : Move parent directory
if [[ ${PS1} ]]; then
  # \er : redraw PS1 @ GNU readline
  # \e[1;5A : Ctrl-Up
  bind '"\e[1;5A":"\ercd ../\n"'
  # \e[1;3A : Alt-Up
  bind '"\e[1;3A":"\ercd ../\n"'
  # Attention: No need bind's option "-x"
fi

