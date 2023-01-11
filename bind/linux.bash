# Attention: No need bind's option "-x"
if [[ ${PS1} ]]; then
  bind '"\e[1;3A":"\e[3;5~\ercd ../\n"'
fi

if type peco &> /dev/null; then
  bind '"\e[1;3B":"\ercd\n"'
fi
