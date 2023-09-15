judge_os()
{
  if ! type uname &> /dev/null; then
    echo "not install uname"
    return 2
  fi

  if [[ "$(uname)" == 'Darwin' ]]; then
    echo 'MacOS'
  elif [[ "$(uname -r)" == *microsoft* ]]; then
    echo 'WSL'
  elif [[ "$(uname)" == *MINGW64_NT* ]]; then
    echo 'Cygwin'
  elif [[ "$(uname -s | cut -c1-5)" == 'Linux' ]]; then
    echo 'Linux'
  else
    echo 'UNKNOWN'
    return 1
  fi
  return 0
}

IsAvailable()
{
  PF=$(judge_os)
  exit_code=$?
  if [ ${exit_code} -ne 0 ]; then
    echo "not support platform"
    return 1
  fi
  export PF
  return 0
}
