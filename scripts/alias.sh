# Rarely command
alias refresh='source $HOME/.bashrc && echo "Refresh Bash"'
alias version='echo "bash versions: ${BASH_VERSION}"'

# File & Directory operation
alias rm='rm -Iv --one-file-system'
alias mv='mv -bv --suffix=".bak"'
alias cp='cp -bv --suffix=".bak"'

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
alias less='less -gMNRqW'

