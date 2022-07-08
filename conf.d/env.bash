### Judge operation system
if [ "$(uname)" == 'Darwin' ]; then
  PF='MacOS'
elif [[ "$(uname -r)" == *microsoft* ]]; then
  PF='WSL'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  PF='Linux'
else
  echo "Your platform ($(uname -a)) is not supported."
  return 1
fi

# Set up special command path
export PATH="${BASH_ROOT}/.local/bin":${PATH}

########## ENVIRONMNT LANGUAGE ##########
#export LANG='ja_JP.UTF-8'
#export LC_ALL='ja_JP.UTF-8'
#export LC_MESSAGES='ja_JP.UTF-8'
