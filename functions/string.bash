replace()
{
  sed -e "s/$1/$2/g"
}

remove_trailing_space()
{
  sed -e "s/\s*$//"
}

###
# Trim leading and trailing whitespace from input lines.
# Accepts argument or stdin.
trim()
{
  local argv=("$1")
  if [ -p /dev/stdin ]; then
    mapfile -t argv < /dev/stdin
  fi

  for line in "${argv[@]}"; do
    line="${line##+([[:space:]])}" # trim preceding
    line="${line%%+([[:space:]])}" # trim trailing
    echo "$line"
  done
}
