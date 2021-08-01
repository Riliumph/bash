if [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/alias/linux.bash
elif [[ ${OS} = "MacOS" ]]; then
  source $BASH_ROOT/scripts/alias/macos.bash
fi
