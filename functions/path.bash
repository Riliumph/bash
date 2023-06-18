###
# path
#
# Display path environment value human readably
path()
{
  echo "${PATH}" | tr ":" "\\n"
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
  path=$(echo -n ${PATH} | tr ":" "\\n" | unique | tr "\\n" ":")
  echo "${path%:}" # remove last colon(:)
}
