###
# GetFaceStatus
# > You can use terminfo/ANSI escape sequences inside substituted functions but not Bash escapes.
# > In particular \[ \] will not work for surrounding non-printable characters.
# > Instead you can use the octal escapes \001 and \002 (e.g. using printf or echo -e).
# > https://wiki.archlinux.org/title/Bash/Prompt_customization
GetFaceStatus()
{
  # If put escape sequence(\[,\]), display it
  # If don't put escape sequence, appear new line problem in terminal
  local -r success="(*'_')<" # \[$(tput setaf 2)\]"
  local -r failure="(*;_;)<" # \[$(tput setaf 1)\]"
  if [ "${LAST_STATUS}" -eq 0 ]; then
    printf "%s %3d" "${success}" "${LAST_STATUS}"
  else
    printf "%s %3d" "${failure}" "${LAST_STATUS}"
  fi
}

###
# Prompt Factory
PromptFactory()
{
  local GIT_BRANCH=''
  if type __git_ps1 &> /dev/null; then
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
