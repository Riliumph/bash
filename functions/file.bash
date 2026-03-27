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
