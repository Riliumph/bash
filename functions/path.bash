###
# path
#
# Display path environment value human readably
path()
{
  printf '%s\n' "${PATH//:/\n}"
}

path_unique()
{
  local path IFS=:
  path=$(printf '%s\n' "${PATH//:/\n}" | unique)
  printf '%s\n' "${path//$'\n'/:}"
}

