# Check environment value
if [[ ! -v CACHE_DIR_FOR_BASH ]]; then
  # If CACHE_DIR_FOR_BASH is undefined,
  # set default path,
  export CACHE_DIR_FOR_BASH=${BASH_ROOT}/cache
fi

# Check log directory existance
if [[ ! -d CACHE_DIR_FOR_BASH ]];then
  mkdir -p ${CACHE_DIR_FOR_BASH}
fi

CD_HISTORY_FOR_BASH=${CACHE_DIR_FOR_BASH}/cd_history.log

# Check log file existance
if [[ ! -f CD_HISTORY_FOR_BASH ]]; then
  touch "${CD_HISTORY_FOR_BASH}"
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
      destination=$(\cat ${CD_HISTORY_FOR_BASH} \
                  | reverse_order \
                  | eval ${trim_duplication} \
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
  pwd >> ${CD_HISTORY_FOR_BASH}
}

alias cd='custom_cd'

###
# _clean_history
#
#
_clean_dir_history()
{
  # Read history file
  uniq_ary=($(cat ${CD_HISTORY_FOR_BASH} \
           | reverse_order \
           | eval $trim_duplication \
           | reverse_order))
  \cp $CD_HISTORY_FOR_BASH $CD_HISTORY_FOR_BASH.bak &> /dev/null
  :> ${CD_HISTORY_FOR_BASH} # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e $line ]]; then
      echo $line >> ${CD_HISTORY_FOR_BASH}
    fi
  done
}

_clean_dir_history

