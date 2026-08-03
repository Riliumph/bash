###
# Detect current operating system environment.
# Output: macOS / WSL / Linux / Cygwin / MSYS/GitBash / UNKNOWN
judge_os()
{
  local kernel_name

  kernel_name="$(uname -s)"

  case "$kernel_name" in
    Darwin)
      echo "macOS"
      ;;
    Linux)
      if grep -qi microsoft /proc/version 2> /dev/null; then
        echo "WSL"
      else
        echo "Linux"
      fi
      ;;
    CYGWIN*)
      echo "Cygwin"
      ;;
    MINGW* | MSYS*)
      echo "MSYS/GitBash"
      ;;
    *)
      echo "UNKNOWN"
      return 1
      ;;
  esac
  return 0
}

IsAvailable()
{
  export PF=""
  PF=$(judge_os)
  exit_code=$?
  if [ "${exit_code}" -ne 0 ]; then
    echo "not support platform"
    return 1
  fi
  return 0
}
