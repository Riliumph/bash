if which git &> /dev/null; then
  case ${PF} in
    MacOS) source "/usr/local/opt/git/etc/bash_completion.d/git-completion.bash";;
    Linux) source "/etc/profile.d/bash_completion.sh";;
    WSL) source "/usr/share/bash-completion/completions/git";;
  esac
fi

##
# Completion rule function
#
# complete only filename
# ex)
# complete -F _comp_only_file less
# @param command name
_comp_only_file()
{
  COMPREPLY=( `compgen -W "$(ls -Fv | grep -v /@*)" $2` )
}

complete -d ls  # default: complete -F _longopt ls

