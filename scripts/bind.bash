if [[ ${OS} = "Linux" ]]; then
  source $BASH_ROOT/scripts/bind/linux.bash
elif [[ ${OS} = "MacOS" ]]; then
  source $BASH_ROOT/scripts/bind/macos.bash
fi
