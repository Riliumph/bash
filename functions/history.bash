ShareHistory()
{
  history -a # Add a previous command to bash_history
  CleanHistory
  history -c # Clear local history in terminal
  history -r # Reload history from bash_history
}

ReloadHistory()
{
  history -c
  history -r
}

ControlHistory()
{
  local -r argc="$#"
  local -r status="$@"
  if ((argc == 0)); then
    echo "Missing args"
    return 1
  elif ((1 < argc)); then
    echo "Excess args: ${argc}"
    return 1
  fi

  case ${status} in
    16) ReloadHistory ;;
    127) ReloadHistory ;;
    *) ShareHistory ;;
  esac
  return 0
}
