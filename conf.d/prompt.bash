########## TERMINAL CODE ##########
if which git &> /dev/null; then
  if [ $OS = 'MacOS' ]; then
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
# __get_face_status
# Don't need escape sequence
# Because this function should execute dynamically
# like __git_ps1 function
__get_face_status()
{
  if [ ${LAST_STATUS} -eq 0 ]; then
    face="(*'_')< "
    err="$(tput setaf 2)" # without escape sequence
  else
    face="(*;_;)< "
    err="$(tput setaf 1)" # without escape sequence
  fi
  echo "${face}${err}${LAST_STATUS}"
}

###
# Prompt Factory
PromptFactory()
{
  local FACE='$(__get_face_status)'
  # According to man page, you should enclose tput by escape sequence
  local norm="\[$(tput sgr0)\]"
  ps1=""
  # Factory of Line 1
  local GIT_BRANCH=''
  if which git &> /dev/null; then
    # Use single-quotation to input function name in PS1
    # __git_ps1 function need executing when PS1 is interpreted.
    GIT_BRANCH='$(__git_ps1)'
  fi
  local user="\[$(tput setaf 4)\]"
  local path="\[$(tput setaf 3)\]"
  local git="\[$(tput setaf 1)\]"
  ps1+="${user}\u"
  ps1+="${norm}:"
  ps1+="${path}\w"
  ps1+="${norm}|"
  ps1+="${git}${GIT_BRANCH}"
  ps1+="${norm}\n"
  # Factory of Line 2
  ps1+="${FACE}"
  ps1+="${norm} \$ "
  # Finalize PS1
  echo "${ps1}"
}

###
# Dispatch
# Do not write complex and long command in PROMPT_COMMAND directly
# Use the dispatch function that wraps the process
Dispatch(){
  export LAST_STATUS="$?"
  #PromptFactory
  share_history
}
export PROMPT_COMMAND='Dispatch'
export PS1="$(PromptFactory)"
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

