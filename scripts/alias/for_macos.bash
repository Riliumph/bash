# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

# File & Directory operation
if which trash &> /dev/null; then
  alias rm='trash-put'
else
  alias rm='rm -v'
fi
alias mv='mv -v'
alias cp='cp -v'
alias mkdirs='mkdir -p'

alias link='ln -v'
alias symlink='ln -nsf'

# List segments
alias ls='ls -FGx'
alias la='ls -A'
alias ll='clear && la -hl'

# Show command
if which htop &> /dev/null; then
  alias top='htop'
fi
alias df='df -h'
alias du='du -h'
alias printenv='printenv | sort -f'
alias less='less -gMNRqW'

alias path='echo ${PATH} | replace : \\n'

# Etc
alias unpatch='patch -R'
alias targz='tar cfvz'
alias untargz='tar xfvz'