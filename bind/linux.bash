[[ $- == *i* ]] || return

# Attention: No need bind's option "-x"
bind '"\e[1;3A":"\e[3;5~\ercd ../\n"'

if command -v peco &> /dev/null; then
  bind '"\e[1;3B":"\ercd\n"'
  bind -x '"\C-r": FuzzyHistory'
fi
