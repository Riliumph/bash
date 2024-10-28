replace()
{
  sed -e "s/$1/$2/g"
}

remove_trailingspace()
{
  sed -e "s/\s*$//"
}

trim()
{
  local argv=("$1")
  if [ -p /dev/stdin ]; then
    mapfile -t argv < /dev/stdin
  fi

  for line in "${argv[@]}"; do
    line="${line##+([[:space:]])}" # trim preceding
    line="${line%%+([[:space:]])}" # trim trailling
    echo "$line"
  done
}
