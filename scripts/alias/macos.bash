# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

# File & Directory operation
if which rmtrash &> /dev/null; then
  alias rm='rmtrash'
else
  alias rm='rm -v'
fi
alias mv='mv -v'
alias cp='cp -v'
alias mkdirs='mkdir -p'

alias link='ln -v'
alias symlink='ln -nsf'

# List segments
if type exa &> /dev/null; then
  alias ls='exa -F'
  alias la='ls -a'
  alias ll='la -l -ghHimS'
  alias lt='ll -T'
else
  alias ls='ls -FGx'
  alias la='ls -A'
  alias ll='clear && la -hlT'
fi

# Show command
if which htop &> /dev/null; then
  alias top='htop'
fi
alias df='df -h'
alias du='du -h'
alias printenv='printenv | sort -f'
alias less='less -gMNRqW'

# Etc
alias unpatch='patch -R'
alias targz='tar cfvz'
alias untargz='tar xfvz'
