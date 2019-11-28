if [[ ${OS} = "Mac" ]]; then
  source $BASH_ROOT/scripts/bind/macos.bash
elif [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/bind/linux.bash
fi
