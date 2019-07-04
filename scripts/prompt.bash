########## TERMINAL CODE ##########
if which git &> /dev/null; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh
  source /usr/local/etc/bash_completion.d/git-completion.bash
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
# GetPromptString
# Get prompt string in terminal
GetPromptString()
{
  local DEBIAN_INFO=${debian_chroot:+($debian_chroot)}
  local GIT_BRANCH=''
  if which git &> /dev/null; then
    GIT_BRANCH='$(__git_ps1)'   # must single-quotation
  fi
  local white=$(MakeControlSequence 00 37)
  local B_lime=$(MakeControlSequence 01 32)
  local yellow=$(MakeControlSequence 00 33)
  local I_red=$(MakeControlSequence 03 31)
  echo "${DEBIAN_INFO}${B_lime}\u${white}:${yellow}\w${white}|${I_red}${GIT_BRANCH}\n${white}\$ "
}

PS1=$(GetPromptString)
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME:+$FUNCNAME(): }'

