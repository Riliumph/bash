###
# open like mac
# alias open=explorer.exeには二つ問題がある
# - デスクトップ上に同名ファイルが存在する場合、そちらを開いてしまう
#   - open hoge.jpg など動かないケース有り
# - カレントディレクトリ以外に開けない
#   - open ../hoge.jpg などは解釈できない
#
if ! type wslpath &> /dev/null; then
  return ;
fi

open()
{
  if [ $# != 1 ]; then
    echo "Usage: open [PATH]"
    echo "Example:"
    echo "  open ."
    return 1;
  fi
  if [ ! -e $1 ]; then
    echo "open: $1 : No such file or directory"
    return 1;
  fi
  cmd.exe /c start "$(wslpath -w "$1")" 2> /dev/null
}
