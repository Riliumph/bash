########## TERMINAL CODE ##########
if which git &> /dev/null; then
  if [ $PF = 'MacOS' ]; then
    # homebrew
    source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
    source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh
  elif [ $PF = 'Linux' ]; then
    # Already installed in ubuntu
    source /etc/profile.d/bash_completion.sh
    source /etc/bash_completion.d/git-prompt
  elif [ $PF = 'WSL' ]; then
    # Already installed in wsl on ubuntu
    source "/usr/share/bash-completion/completions/git"
    source "/etc/bash_completion.d/git-prompt"
  fi
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

