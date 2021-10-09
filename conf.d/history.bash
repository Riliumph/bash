shopt -u histappend  # Unset shell option
export HISTFILE=${CACHE}/.bash_history
export HISTCONTROL=ignoreboth   # ex) ignoredups,ignorespace,erasedups
### Ignore commands
# command name with 4 or fewer characters
export HISTIGNORE=?:??:???:????:${HISTIGNORE}
# Specific command names
export HISTIGNORE=cd*:${HISTIGNORE}
export HISTIGNORE=git*:${HISTIGNORE}
export HISTIGNORE=which*:${HISTIGNORE}
export HISTIGNORE=history*:${HISTIGNORE}

share_history()
{
  history -a  # Add a previous command to bash_history
  history -c  # Clear local history in terminal
  history -r  # Reload history from bash_history
}
