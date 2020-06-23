###
# path
#
# Display path environment value human readably
path()
{
  echo ${PATH} | tr ":" "\\n"
}

