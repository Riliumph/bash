#!/bin/bash

###
# Convert to absolute path
# @param $1 path
# @return absolute path
abs_dirname() {
  local path="$1"

  # Check path existence one by one
  while [ -n "$path" ]; do
    cd "${path%/*}"  # Remove the shortest pattern(/*) from right
    local name="${path##*/}"  # Remove the longest pattern(*/) from left
    path="$(readlink "$name" || true)"
  done

  pwd -P  # return string
}

installed_path=$(abs_dirname "$0")

# Add bash setting for vim to bashrc
echo "export BASH_ROOT=${installed_path}" >> "$HOME/.bashrc"
echo 'source $BASH_ROOT/config.bash' >> "$HOME/.bashrc"
