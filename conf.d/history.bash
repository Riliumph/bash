shopt -u histappend # disable auto save when session finalize
export HISTCONTROL=ignoreboth:erasedups
### Ignore commands
# command name with 3 or fewer characters
export HISTIGNORE="?:??:${HISTIGNORE}"
# Specific command names
export HISTIGNORE="cd*:ls*:pwd:${HISTIGNORE}"
export HISTIGNORE="* --help:${HISTIGNORE}"
