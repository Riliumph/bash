### Judge operation system
if [ "$(uname)" == 'Darwin' ]; then
  OS='MacOS'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

########## ENVIRONMNT LANGUAGE ##########
#export LANG='ja_JP.UTF-8'
#export LC_ALL='ja_JP.UTF-8'
#export LC_MESSAGES='ja_JP.UTF-8'
