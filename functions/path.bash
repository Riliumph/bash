###
# path
#
# Display path environment value human readably
# Print PATH entries line by line.
path()
{
  printf '%s\n' "${PATH//:/$'\n'}"
}

###
# Remove duplicated entries from PATH.
path_unique()
{
  local path IFS=:
  path=$(printf '%s\n' "${PATH//:/$'\n'}" | unique)
  printf '%s\n' "${path//$'\n'/:}"
}
