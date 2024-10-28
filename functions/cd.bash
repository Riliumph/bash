###
# Cutom cd Command
#
# @param $1 destination directory
# Args num 0:
#    Show error and return
#    but if you has peco, select from current directory
# Args num 1:
#    Execute cdls commands
# Args "-" ( optional args num 1)
#    Show path-history you have moved by peco
custom_cd()
{
  local -r argc="$#"
  case ${argc} in
    0)
      if which peco &> /dev/null; then
        destination=$(find ./ -maxdepth 1 -mindepth 1 -type d | asc_order | peco)
      fi
      ;;
    *) # Don't use "$@" to forget arguments' position info
      # Join all positional parameters to support paths with half-width space
      # After that, use this by enclosing in double quotation.
      local destination="$*"
      ;;
  esac

  # History Option
  if [[ "${destination}" == '-' ]]; then
    if which peco &> /dev/null; then
      destination=$(reverse_order "${CD_HISTORY}" \
        | unique \
        | peco) # Cannot use --query option
    fi
  fi

  # Don't move $HOME
  if [ -z "${destination}" ]; then
    echo 'Missing args'
    return 1
  fi

  # call builtin command to avoid recursive call
  # builtin cd or \cd
  builtin cd "${destination}" || return
  clear && ls

  # Log path history and Convert relative path to absolute path
  pwd >> "${CD_HISTORY}"
}

alias cd='custom_cd'
