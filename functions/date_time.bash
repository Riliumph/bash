###
# Custom Date Command
#
# Approximately compliant with C#
# When the number of argument is 0, use default format
# @param Custom Date and Time Format Strings
date_time()
{
  local -r argc=$#
  local format
  case $argc in
    0) format='yyyy/MM/dd hh:mm:ss' ;;
    1) format=$1 ;;
    *)
      echo 'Too many argument for date_time command'
      return 1
      ;;
  esac
  format=$(echo "${format}" \
    | sed -e 's/yyyy/%Y/g' | sed -e 's/yy/%y/g' | sed -e 's/y/%-y/g' \
    | sed -e 's/MMMM/%B/g' | sed -e 's/MMM/%b/g' | sed -e 's/MM/%m/g' | sed -e 's/(^%)M/%-m/g' \
    | sed -e 's/dddd/%A/g' | sed -e 's/ddd/%a/g' \
    | sed -e 's/dd/%d/g' | sed -e 's/(^%)d/%-d/g' \
    | sed -e 's/hh/%H/g' | sed -e 's/(^%)h/%-H/g' \
    | sed -e 's/mm/%M/g' | sed -e 's/(^%)m/%-M/g' \
    | sed -e 's/ss/%S/g' | sed -e 's/(^%)s/%-S/g')
  date "+${format}"
}
