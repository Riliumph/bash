###
# GetFaceStatus
# > You can use terminfo/ANSI escape sequences inside substituted functions but not Bash escapes.
# > In particular \[ \] will not work for surrounding non-printable characters.
# > Instead you can use the octal escapes \001 and \002 (e.g. using printf or echo -e).
# > https://wiki.archlinux.org/title/Bash/Prompt_customization
GetFaceStatus()
{
  # Change to 1byte control data by ANSI-C Quoting
  local green=$'\001\e[32m\002'
  local red=$'\001\e[31m\002'
  local reset=$'\001\e[0m\002'

  local -r success="(*'_')<"
  local -r failure="(*;_;)<"

  if [ "${LAST_STATUS}" -eq 0 ]; then
    printf "%s%s %3d%s" "$green" "$success" "$LAST_STATUS" "$reset"
  else
    printf "%s%s %3d%s" "$red" "$failure" "$LAST_STATUS" "$reset"
  fi
}

###
# Prompt Factory
PromptFactory()
{
  local GIT_BRANCH=''
  if [[ "$(type -t __git_ps1 2> /dev/null)" == "function" ]]; then
    # __git_ps1 need executing when PS1 is interpreted.
    GIT_BRANCH='$(__git_ps1)'
  fi
  local -r FACE='$(GetFaceStatus)'
  # color
  local -r norm="\[\e[0m\]"  # white
  local -r host="\[\e[32m\]" # green
  local -r user="\[\e[34m\]" # blue
  local -r path="\[\e[33m\]" # yellow
  local -r git="\[\e[31m\]"  # red
  local ps1=""
  # Factory of Line 1
  # Use $'\n' as escaped CRLF in Cygwin enabled igncr option
  ps1+="[\t]${user}\u${norm}@${host}\h${norm}:${path}\w${norm}|${git}${GIT_BRANCH}"$'\n'
  # Factory of Line 2
  ps1+="${norm}${FACE}${norm} \$ "
  # Finalize PS1
  echo "${ps1}"
}

SetPrompt()
{
  ps1="$(PromptFactory)"
  export PS1="${ps1}"
}
