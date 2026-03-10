GIT_LOCAL="$BASH_ROOT/.local/git"
GIT_FILE_LOCATION=(
  # 共通
  "/usr/share"
  "/usr/local/share"
  # Git の contrib
  "/usr/share/git-core"
  "/usr/share/git-core/contrib/completion"
  # bash-completion の標準配置
  "/etc/bash_completion.d"
  "/usr/share/bash-completion"
  "/usr/share/bash-completion/completions"
  # Homebrew (Intel / Apple Silicon)
  "/usr/local/opt"
  "/usr/local/share/git-core/contrib/completion"
  "/opt/homebrew/opt"
  "/opt/homebrew/share/git-core/contrib/completion"
  "/opt/homebrew/etc/bash_completion.d"
  # MacPorts
  "/opt/local/share/git-core/contrib/completion"
  "/opt/local/etc/bash_completion.d"
  # Xcode / CLT（インストールしている場合）
  "/Applications/Xcode.app/Contents/Developer/usr/share/git-core"
  "/Library/Developer/CommandLineTools/usr/share/git-core"
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
