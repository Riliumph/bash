#!/bin/bash

if type readlpath &> /dev/null; then
  echo "not install readpath"
  exit 1
fi

this_file=$(realpath "$0")
BASH_ROOT="${this_file%/*}" # var name must be BASH_ROOT
if [ -n "${BASH_ROOT}" ]; then
  # use BASH_ROOT in git.bash
  if ! source "$BASH_ROOT/conf.d/git.bash"; then
    echo "fail to load $BASH_ROOT/conf.d/git.bash"
    exit 1
  fi
  if ! source "$BASH_ROOT/functions/git.bash"; then
    echo "fail to load $BASH_ROOT/functions/git.bash"
    exit 1
  fi
else
  echo "undefined BASH_ROOT"
  exit 1
fi

echo "installing git-prompt ..."
InstallGitPrompt
echo "installing git-completion ..."
InstallGitCompletion
# Add bash setting for vim to bashrc
echo "setting bashrc ..."
echo "export BASH_ROOT=${BASH_ROOT}" >> "$HOME/.bashrc"
echo 'source $BASH_ROOT/config.bash' >> "$HOME/.bashrc"
