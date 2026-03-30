#!/bin/bash
set -euo pipefail
#set -x


################################################################################
# Utils
################################################################################
info() {
  echo "INFO: $*"
}

die() {
  echo "ERROR: $*" >&2
  exit 1
}

safe_source() {
  local file="$1"
  [[ -f "$file" ]] || die "File not found: $file"
  # shellcheck disable=SC1090
  source "$file" || die "Failed to source: $file"
}

append_if_not_exists() {
  local line="$1"
  local file="$2"
  grep -Fxq "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

abs_dirname() {
  local path
  path="$(cd "$(dirname "$1")" && pwd -P)"
  echo "$path"
}

################################################################################
# Main
################################################################################

info "install custom bash"
# requirement
[[ "${BASH_SOURCE[0]}" == "$0" ]] ||  die "This script must be executed, not sourced"

SCRIPT_DIR="$(abs_dirname "$0")"

# ---- bashrc setup ----
BASHRC="$HOME/.bashrc"

info "setting bashrc ..."

append_if_not_exists "export BASH_ROOT=$SCRIPT_DIR" "$BASHRC"
append_if_not_exists 'source $BASH_ROOT/config.bash' "$BASHRC"

info "Done!"
