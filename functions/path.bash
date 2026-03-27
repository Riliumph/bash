###
# path
#
# Display path environment value human readably
path()
{
  printf '%s\n' "${PATH//:/\n}"
}

get_filename()
{
  echo "${1##*/}"
}

get_extension()
{
  echo "${1##.}"
}

get_directory()
{
  echo "${1%/*}"
}

path_unique()
{
  local path IFS=:
  path=$(printf '%s\n' "${PATH//:/\n}" | unique)
  printf '%s\n' "${path//$'\n'/:}"
}

