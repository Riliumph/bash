###
# Convert to absolute path
# @param $1 path
# @return absolute path
abs_path()
{
  local target="$1"

  [ -n "$target" ] || return 1

  ( # Use a subshell to avoid changing the caller's working directory
    if [ -d "$target" ]; then
      cd -P -- "$target" && pwd
    else
      local dir base
      dir=$(dirname -- "$target") || exit 1
      base=$(basename -- "$target") || exit 1

      cd -P -- "$dir" || exit 1
      printf '%s/%s\n' "$(pwd)" "$base"
    fi
  )
}
