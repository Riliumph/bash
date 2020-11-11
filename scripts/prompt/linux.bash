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
# MakeControlSequence
# PLEASE USE WITH CAUTION
# Because it only judges the number of arguments
# @param $1 font type (00, 01, 04, 05)
# @param $2 fg color (31 - 37)
# @param $3 bg color (41 - 47)
MakeControlSequence()
{
  local argc=$#
  local font_type=$1
  local fg_color=$2
  local bg_color=$3
  case ${argc} in
    0) echo "Missing argument"; return 1;;
    1) echo "\[\e[${font_type}\]"; return 0;;
    2) echo "\[\e[${font_type};${fg_color}m\]"; return 0;;
    3) echo "\[\e[${font_type};${fg_color}m\e[${bg_color}m\]"; return 0;;
    *) echo "Too many argument"; return 1;;
  esac
}

###
# StatusFace
# Judge last command status
# Don't use MakeControlSequence
# This function should be executed every paint
# So, don't use escape sequence as string
StatusFace() {
  if [ $? -eq 0 ]; then
    face="\[\e[32m\](*'_')"
  else
    face="\[\e[31m\](*;_;)"
  fi
  echo "${face}\[\e[m\]"
}

###
# GetPromptString
# Get prompt string in terminal
GetPromptString()
{
  local GIT_BRANCH=''
  if which git &> /dev/null; then
    GIT_BRANCH='$(__git_ps1)'   # must single-quotation
  fi
  local def="\[\e[0m\]"
  local blue=$(MakeControlSequence 00 34)
  local white=$(MakeControlSequence 00 37)
  local B_lime=$(MakeControlSequence 01 32)
  local yellow=$(MakeControlSequence 00 33)
  local I_red=$(MakeControlSequence 03 31)
  echo "${blue}\u${def}:${yellow}\w${def}|${I_red}${GIT_BRANCH}${def}\n"
}

PS1=$(GetPromptString)$(StatusFace)" \$ "
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'
