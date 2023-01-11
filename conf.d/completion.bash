if which git &> /dev/null; then
  case ${PF} in
    MacOS) source "/usr/local/opt/git/etc/bash_completion.d/git-completion.bash" ;;
    Linux) source "/etc/profile.d/bash_completion.sh" ;;
    WSL) source "/usr/share/bash-completion/completions/git" ;;
  esac
fi

# ls complete only directory
complete -d ls # -d = directory
