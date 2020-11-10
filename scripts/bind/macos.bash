# Attention: No need bind's option "-x"
if [[ ${PS1} ]]; then
  bind -x '"\e[A" : cd ../'
fi

if type peco &> /dev/null; then
  bind -x '"\e[B" : cd'
fi

