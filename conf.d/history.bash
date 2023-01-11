shopt -u histappend # Unset shell option
export HISTFILE="$CACHE/.bash_history"
export HISTCONTROL=ignoreboth # ex) ignoredups,ignorespace,erasedups
### Ignore commands
# command name with 4 or fewer characters
export HISTIGNORE="?:??:???:????:${HISTIGNORE}"
# Specific command names
export HISTIGNORE="cd*:${HISTIGNORE}"
export HISTIGNORE="type*:which*:${HISTIGNORE}"
export HISTIGNORE="history*:${HISTIGNORE}"
