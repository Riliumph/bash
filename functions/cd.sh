###
# Cutom cd Command
#
# @param $1 destination directory
# Args num 0:
#    Show error and return
# Args num 1:
#    Execute cdls commands
# Args "-" ( optional args num 1)
#    Show path-history you have moved by peco
custom_cdls()
{
  local -r argc=$#
  local path
  case ${argc} in
    0)echo 'Missing args';
      return 1
      ;;
    1)path=$1
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
  # \cd => builtin cd
  \cd ${path} && clear && ls
}

alias cd='custom_cdls'

