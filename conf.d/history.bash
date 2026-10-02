shopt -u histappend # disable auto save when session finalize
export HISTCONTROL=ignoreboth:erasedups
### Ignore commands
# Specific command names
export HISTIGNORE="cd*:ls*:pwd:${HISTIGNORE}"
export HISTIGNORE="* --help:${HISTIGNORE}"
