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
  PF='MacOS'
elif [[ "$(uname -r)" == *microsoft* ]]; then
  PF='WSL'
elif [[ "$(uname)" == *MINGW64_NT* ]]; then
  PF='Cygwin'
elif [[ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]]; then
  PF='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  return 1
fi
