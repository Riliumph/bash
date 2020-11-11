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
# Dispatch
# Do not write complex and long command in PROMPT_COMMAND directly
# Use the dispatch function that wraps the process
Dispatch(){
  export EXIT_STATUS="$?"
  local last_status=${EXIT_STATUS}
  # Should enclose tput by escape sequence according to man page
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
  if [ ${last_status} -eq 0 ]; then
    face="(*'_')< "
    err="\[$(tput setaf 2)\]"
  else
    face="(*;_;)< "
    err="\[$(tput setaf 1)\]"
  fi
  ps1+="${face}"
  ps1+="${err}${last_status} "
  ps1+="${norm}\$ "
  # Finalize PS1
  PS1=${ps1}
}
export PROMPT_COMMAND='Dispatch'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

