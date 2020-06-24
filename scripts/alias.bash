if [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/alias/linux.bash
elif [[ ${OS} = "Mac" ]]; then
  source $BASH_ROOT/scripts/alias/macos.bash
fi
