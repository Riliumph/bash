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
custom_cdls()
{
  local -r argc=$#
  local path
  case ${argc} in
    0)if ! which peco &> /dev/null; then
        echo 'Missing args';
        return 1;
      fi
      local asc_order='sort -f'
      path=$(find ./ -maxdepth 1 -type d | eval $asc_order | peco)
      ;;
    1)path=$1
      if which peco &> /dev/null; then
        if [[ ${path} == '-' ]];then
          local trim_duplication='awk '\''!dictionaty[$0]++'\'''
          local reverse_order='tac'
          path=$(cat ${CD_HISTORY_FOR_BASH} \
                 | eval ${reverse_order} \
                 | eval ${trim_duplication} \
                 | peco) # Cannot use --query option
        fi
      fi
      ;;
    *)echo 'Too many args for cd command'
      return 1
      ;;
  esac
  # Check existance
  if [[ ! ${path} == '-' && ! -e ${path} ]]; then
    echo "Missing path: ${path}"
    return 1
  fi

  # Log path history and Convert relative path to absolute path
  readlink -f ${path} >> ${CD_HISTORY_FOR_BASH}

  # \cd => builtin cd
  \cd ${path} && clear && ls
}

alias cd='custom_cdls'

###
# _clean_history
#
#
_clean_dir_history()
{
  local trim_duplication='awk '\''!dictionaty[$0]++'\'''
  local reverse_order='tac'
  # Read history file
  uniq_ary=($(cat ${CD_HISTORY_FOR_BASH} \
           | eval $reverse_order \
           | eval $trim_duplication \
           | eval $reverse_order))
  \cp $CD_HISTORY_FOR_BASH $CD_HISTORY_FOR_BASH.bak &> /dev/null
  :> ${CD_HISTORY_FOR_BASH} # truncate file
  for line in "${uniq_ary[@]}"; do
    if [[ -e $line ]]; then
      echo $line >> ${CD_HISTORY_FOR_BASH}
    fi
  done
}

_clean_dir_history

