##
# Completion rule function
#
# complete only filename
# ex)
# complete -F _comp_only_file less
# @param command name
_comp_only_file(){
  COMPREPLY=( `compgen -W "$(ls -Fv | grep -v /@*)" $2` )
}

complete -d ls  # default: complete -F _longopt ls

