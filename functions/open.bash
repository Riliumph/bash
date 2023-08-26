###
# open like mac
if ! type wslpath &> /dev/null; then
  return
fi

open()
{
  if [ $# != 1 ]; then
    echo "Usage: open [PATH]"
    echo "Example:"
    echo "  open ."
    return 1
  fi
  if [ ! -e "$1" ]; then
    echo "open: $1 : No such file or directory"
    return 1
  fi
  cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null
}
