GIT_LOCAL="$BASH_ROOT/.local/git"
GIT_FILE_LOCATION=(
  "/usr/share"
  "/usr/local/opt"
  "/etc/bash_completion.d"
)

# 共通：ファイル取得関数
# usage: _InstallGitHelper <local_filename> <remote_filename>
_InstallGitHelper() {
  local target="$1"
  local remote="$2"
  local from="https://raw.githubusercontent.com/git/git/master/contrib/completion"

  mkdir -p "${GIT_LOCAL}"

  # ローカル検索
  local found
  found="$(find "${GIT_FILE_LOCATION[@]}" -type f -name "${remote}" 2>/dev/null | head -n 1)"

  if [[ -n "$found" ]]; then
    echo "copy: ${found} -> ${GIT_LOCAL}/${target}"
    cp -f "$found" "${GIT_LOCAL}/${target}"
  else
    echo "download: ${remote}"
    curl -o "${GIT_LOCAL}/${target}" "${from}/${remote}"
  fi
}

LoadGitFiles() {
  if [[ -e "${GIT_LOCAL}/git-prompt.sh" ]]; then
    source "${GIT_LOCAL}/git-prompt.sh"
  elif [[ -e "${GIT_LOCAL}/git-prompt" ]]; then
    source "${GIT_LOCAL}/git-prompt"
  else
    echo "not found git-prompt"
  fi

  if [[ -e "${GIT_LOCAL}/git-completion.bash" ]]; then
    source "${GIT_LOCAL}/git-completion.bash"
  else
    echo "not found git-completion"
  fi
}

InstallGitPrompt() {
  _InstallGitHelper "git-prompt.sh" "git-prompt.sh"
}

InstallGitCompletion() {
  _InstallGitHelper "git-completion.bash" "git-completion.bash"
}
