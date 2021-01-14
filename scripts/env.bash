########## ENVIRONMNT LANGUAGE ##########
#export LANG='ja_JP.UTF-8'
#export LC_ALL='ja_JP.UTF-8'
#export LC_MESSAGES='ja_JP.UTF-8'

########## HISTORY SETTING ##########
share_history()
{
  history -a  # Add a previous command to bash_history
  history -c  # Clear local history in terminal
  history -r  # Reload history from bash_history
}

shopt -u histappend  # Unset shell option
export HISTCONTROL=ignoreboth   # ex) ignoredups,ignorespace,erasedups
### Ignore commands
# command name with 4 or fewer characters
export HISTIGNORE=?:??:???:????:${HISTIGNORE}
# Specific command names
export HISTIGNORE=cd*:${HISTIGNORE}
export HISTIGNORE=which*:${HISTIGNORE}
export HISTIGNORE=history*:${HISTIGNORE}

