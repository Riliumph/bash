#!/bin/bash
set -euo pipefail


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

command_exists() {
  command -v "$1" >/dev/null 2>&1
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
# requirement
[[ "${BASH_SOURCE[0]}" == "$0" ]] ||  die "This script must be executed, not sourced"

SCRIPT_DIR="$(abs_dirname "$0")"

# ---- load dependencies ----
safe_source "$SCRIPT_DIR/conf.d/git.bash"
safe_source "$SCRIPT_DIR/functions/git.bash"

# ---- install ----
info "installing git-prompt ..."
InstallGitPrompt

info "installing git-completion ..."
InstallGitCompletion

# ---- bashrc setup ----
BASHRC="$HOME/.bashrc"

info "setting bashrc ..."

append_if_not_exists "export BASH_ROOT=$SCRIPT_DIR" "$BASHRC"
append_if_not_exists 'source $BASH_ROOT/config.bash' "$BASHRC"

info "Done!"
