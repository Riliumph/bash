# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

# File & Directory operation
alias rm='rm -v'
alias mv='mv -v'
alias cp='cp -v'
if [ $OS = 'Linux' ]; then
  alias rm='rm -I --one-file-system'
  alias mv='mv -b --suffix=".bak"'
  alias cp='cp -b --suffix=".bak"'
fi
if which trash &> /dev/null; then
  alias rm='trash-put'
fi
alias mkdirs='mkdir -p'

alias ln='ln -v'
alias link='ln'
alias symlink='ln -s'
if [ $OS = 'Linux' ]; then
  alias link='ln -b --suffix=".bak"'
  alias symlink='link --no-dereference'
fi

# List segments
alias ls='ls -hFx'
if [ $OS = 'Linux' ]; then
  alias ls='ls -v --color=auto --group-directories-first'
  alias la='ls --almost-all'
  alias ll='clear && la -l --time-style="+%y-%m-%d %H:%M:%S"'
elif [ $OS = 'Linux' ]; then
  alias ls='ls -G'
  alias la='ls -A'
  alias ll='clear && la -l | sort -V'
fi

# Show command
if which htop &> /dev/null; then
  alias top='htop'
fi
if [ $OS = 'Linux' ]; then
  alias ps='ps --sort=start_time'
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
