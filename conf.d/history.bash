shopt -u histappend # disable auto save when session finalize
export HISTFILE="$CACHE/.bash_history"
export HISTCONTROL=ignoreboth
### Ignore commands
# command name with 3 or fewer characters
export HISTIGNORE="?:??:???:${HISTIGNORE}"
# Specific command names
export HISTIGNORE="cd*:${HISTIGNORE}"
export HISTIGNORE="type*:which*:${HISTIGNORE}"
export HISTIGNORE="history*:${HISTIGNORE}"
