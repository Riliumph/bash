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
  local -r argc=$#
  local destination=$*
  case ${argc} in
    0) if which peco &> /dev/null; then
         destination=$(find ./ -maxdepth 1 -mindepth 1 -type d | asc_order | peco)
       fi
       ;;
    1) destination=$1
       ;;
  esac

  # History Option
  if [[ ${destination} == '-' ]];then
    if which peco &> /dev/null; then
      destination=$(\cat ${CD_HISTORY} \
                  | reverse_order \
                  | unique \
                  | peco) # Cannot use --query option
    fi
  fi

  # Don't move $HOME
  if [ -z $destination ]; then
    echo 'Missing args';
    return 1;
  fi

  # \cd => builtin cd
  \cd ${destination}
  if [ $? -ne 0 ]; then
    return $?
  fi
  clear && ls

  # Log path history and Convert relative path to absolute path
  pwd >> ${CD_HISTORY}
}

alias cd='custom_cd'
