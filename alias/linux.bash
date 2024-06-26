# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

# Reflect Root
alias sudo='sudo '

# File & Directory operation
if which trash &> /dev/null; then
  alias rm='trash-put'
else
  alias rm='rm -Iv --one-file-system'
fi
alias mv='mv -bv --suffix=".bak"'
alias cp='cp -bv --suffix=".bak"'
alias mkdirs='mkdir -p'

alias link='ln -bv --suffix=".bak"'
alias symlink='link --symbolic --no-dereference'

# Judge to add color
if [[ -x /usr/bin/dircolors ]]; then
  alias ls='ls -v --color=auto --classify --format=across --group-directories-first'
  alias la='ls --almost-all --ignore-backups'
  alias ll='clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  alias ls='ls -v --classify --format=across --group-directories-first'
  alias la='ls --almost-all --ignore-backups'
  alias ll='clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"'
fi

# Show command
if which htop &> /dev/null; then
  alias top='htop'
fi

alias ps='ps --sort=start_time'
alias printenv='printenv | sort -f'
alias less='less -gMNRqW'

# Etc
alias unpatch='patch -R'
alias targz='tar cfvz'
alias untargz='tar xfvz'
