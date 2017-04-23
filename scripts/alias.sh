# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

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
  alias ls='ls -v --color=auto --classify --format=across --group-directories-first --sort=extension'
  alias la='ls --almost-all --ignore-backups'
  alias ll='clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"'
else
  alias ls='ls -v --classify --format=across --group-directories-first --sort=extension'
  alias la='ls --almost-all --ignore-backups'
  alias ll='clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"'
fi

# Show command
if which htop &> /dev/null; then
  alias top='htop'
fi
alias df='df -h --inode'
alias du='du -h --all'
alias ps='ps --sort=start_time'
alias env='env | sort -f'
alias less='less -gMNRqW'

alias show_path='echo ${PATH} | replace : \\n'
