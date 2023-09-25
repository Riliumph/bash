if [[ ! -v XDG_CONFIG_HOME ]]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi
export GIT_CONFIG_DIR="$XDG_CONFIG_HOME/git"
GIT_FILE_LOCATION=("/usr/share")              # Default
GIT_FILE_LOCATION+=("/usr/local/opt")         # for macOS
GIT_FILE_LOCATION+=("/etc/bash_completion.d") # for ubuntu
PATH="$GIT_CONFIG_DIR:$PATH"
