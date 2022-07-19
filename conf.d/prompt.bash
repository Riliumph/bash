########## TERMINAL CODE ##########
if which git &> /dev/null; then
  case ${PF} in
    MacOS) source "/usr/local/opt/git/etc/bash_completion.d/git-prompt.sh";;
    Linux) source "/etc/bash_completion.d/git-prompt";;
    WSL) source "/etc/bash_completion.d/git-prompt";;
    Cygwin) source "/etc/profile.d/git-prompt.sh";;
  esac
  #export GIT_PS1_SHOWUPSTREAM=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE=1
fi

# Enclose in single quotes for dynamic operation
export PROMPT_COMMAND='Dispatch'
# Enclose in double quotes for static operation
export PS1="$(PromptFactory)"
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

