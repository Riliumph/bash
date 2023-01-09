# Reuire: Use stdout(FD 1)
if [[ ! -t 1 ]];then
  echo "Cannot use stdout(fd 1)"
  # Do not exe to avoid following error in scp
  # bind: warning: line editing not enabled
  return 1
fi

# Require: ROOT Environment value
if [[ ! -v BASH_ROOT ]];then
  echo '$BASH_ROOT is undefined!!'
  return 1
fi

# Require: Support operation system
if [[ "$(uname)" == 'Darwin' ]]; then
  export PF='MacOS'
elif [[ "$(uname -r)" == *microsoft* ]]; then
  export PF='WSL'
elif [[ "$(uname)" == *MINGW64_NT* ]]; then
  export PF='Cygwin'
elif [[ "$(uname -s | cut -c1-5)" == 'Linux' ]]; then
  export PF='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  return 1
fi
