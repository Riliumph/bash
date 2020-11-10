if [[ ${OS} == 'Linux' ]]; then
  source "$BASH_ROOT/scripts/prompt/linux.bash"
elif [[ ${OS} == 'Mac' ]]; then
  source "$BASH_ROOT/scripts/prompt/macos.bash"
fi
