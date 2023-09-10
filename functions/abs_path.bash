###
# Convert to absolute path
# @param $1 path
# @return absolute path
abs_dirname()
{
  local path="$1"

  # Check path existence one by one
  while [ -n "$path" ]; do
    # Remove the shortest pattern(/*) from right
    builtin cd "${path%/*}" || exit
    # Remove the longest pattern(*/) from left
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
    echo "path: $path"
  done

  pwd -P # return string
}
