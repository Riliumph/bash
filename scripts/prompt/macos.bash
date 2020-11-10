########## TERMINAL CODE ##########
if which git &> /dev/null; then
  if [ $OS = 'Mac' ]; then
    # homebrew
    source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
    source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh
  elif [ $OS = 'Linux' ]; then
    # Already installed in ubuntu
    # /etc/profile.d/bash_completion.sh
    # /etc/bash_completion.d/git-prompt
    :
  fi
  #export GIT_PS1_SHOWUPSTREAM=1
  export GIT_PS1_SHOWUNTRACKEDFILES=1
  export GIT_PS1_SHOWSTASHSTATE=1
  export GIT_PS1_SHOWDIRTYSTATE=1
fi


###
# StatusFace
# Judge last command status
# Don't use MakeControlSequence
# This function should be executed every paint
# So, don't use escape sequence as string
StatusFace() {
  local status=$?
  if [ $status -eq 0 ]; then
    color='$(tput setaf 2)'
    face="(*'_')< "
    face+="\[$color\]""$status"
  else
    color='$(tput setaf 1)'
    face="(*;_;)< "
    face+="\[$color\]""$status"
  fi
  echo "${face}"
}

###
# GetPromptString
# Get prompt string in terminal
SetPromptString()
{
  local GIT_BRANCH=''
  if which git &> /dev/null; then
    GIT_BRANCH='$(__git_ps1)' # Use single-quotation for dynamic prompt
  fi
  local norm='$(tput sgr0)'
  local user='$(tput setaf 4)'
  local path='$(tput setaf 3)'
  local git='$(tput setaf 1)'
  ps1=""
  ps1+="\[$user\]\u"
  ps1+="\[$norm\]:"
  ps1+="\[$path\]\w"
  ps1+="\[$norm\]|"
  ps1+="\[$git\]$GIT_BRANCH"
  ps1+="\[$norm\]\n"
  ps1+="$(StatusFace)"
  ps1+="\[$norm\] \$"
  echo $ps1
}
PS1="$(SetPromptString) "
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

