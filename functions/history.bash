share_history()
{
  history -a # Add a previous command to bash_history
  history -c # Clear local history in terminal
  history -r # Reload history from bash_history
}

reload_history()
{
  history -c
  history -r
}

control_history()
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
    127) reload_history ;; # command not found
    *) share_history ;;
  esac
  return 0
}
