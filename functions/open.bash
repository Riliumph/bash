if ! command -v wslpath &> /dev/null; then
  return
fi

###
# open like mac
open()
{
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    printf '%s\n' \
      "Usage: open PATH" \
      "" \
      "Open PATH with Windows default application." \
      "" \
      "Example:" \
      "  open ."
    return 0
  fi

  if [ $# -ne 1 ]; then
    echo "Usage: open [PATH]"
    echo "Example:"
    echo "  open ."
    return 1
  fi
  if [ ! -e "$1" ]; then
    echo "open: cannot access '$1': No such file or directory"
    return 1
  fi
  cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null
}
