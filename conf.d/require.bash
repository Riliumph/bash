# Reuire: Use stdout(FD 1)
if [[ ! -t 1 ]]; then
  echo "Cannot use stdout(fd 1)"
  # Do not exe to avoid following error in scp
  # bind: warning: line editing not enabled
  return 1
fi

# Require: ROOT Environment value
if [[ ! -v BASH_ROOT ]]; then
  echo '$BASH_ROOT is undefined!!'
  return 1
fi
