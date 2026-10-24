# Require: interactive mode
if [[ $- != *i* ]]; then
  echo "Not running in interactive mode"
  # Do not exe to avoid following error in scp
  # bind: warning: line editing not enabled
  return 1
fi

# Require: ROOT Environment value
if [[ ! -v BASH_ROOT ]]; then
  echo '$BASH_ROOT is undefined!!'
  return 1
fi
