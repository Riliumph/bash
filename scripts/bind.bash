if [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/bind/linux.bash
elif [[ ${OS} = "Mac" ]]; then
  source $BASH_ROOT/scripts/bind/macos.bash
fi
