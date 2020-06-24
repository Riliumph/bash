if [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/alias/for_linux.bash
elif [[ ${OS} = "Mac" ]]; then
  source $BASH_ROOT/scripts/alias/for_macos.bash
fi
