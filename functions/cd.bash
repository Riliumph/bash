
CD_HISTORY=${CACHE}/cd_history.log

# Check log file existance
if [[ ! -f CD_HISTORY ]]; then
  touch "${CD_HISTORY}"
fi

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
                  | eval ${unique} \
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

###
# _clean_history
#
#
_clean_dir_history()
{
  # Read history file
  uniq_ary=($(cat ${CD_HISTORY} \
           | reverse_order \
           | eval $unique \
           | reverse_order))
  \cp $CD_HISTORY $CD_HISTORY.bak &> /dev/null
  :> ${CD_HISTORY} # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e $line ]]; then
      echo $line >> ${CD_HISTORY}
    fi
  done
}

_clean_dir_history

