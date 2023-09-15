#!/bin/bash

if type readlpath &> /dev/null; then
  echo "not install readpath"
  exit 1
fi

source "./functions/git.bash"
if [ $? -ne 0 ]; then
  echo "fail to load git script"
  exit 1
fi

this_file=$(realpath "$0")
BASH_ROOT="${this_file%/*}"

echo "installing git-prompt ..."
InstallGitPrompt
echo "installing git-completion ..."
InstallGitCompletion
# Add bash setting for vim to bashrc
echo "setting bashrc ..."
echo "export BASH_ROOT=${BASH_ROOT}" >> "$HOME/.bashrc"
echo 'source $BASH_ROOT/config.bash' >> "$HOME/.bashrc"
