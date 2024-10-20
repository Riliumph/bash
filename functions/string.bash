replace()
{
  sed -e "s/$1/$2/g"
}

remove_trailingspace()
{
  sed -e "s/\s*$//"
}
