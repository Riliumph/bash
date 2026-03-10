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

LoadGitFiles()
{
  if ! HasGitPrompt; then
    local gp_candidates=(
      "${GIT_LOCAL}/git-prompt.sh"
      "${GIT_LOCAL}/git-prompt"
    )
    local gp found=0
    for gp in "${gp_candidates[@]}"; do
      [[ -r "$gp" ]] || continue
      # shellcheck disable=SC1090
      source "$gp"
      found=1
      echo "loaded git-prompt (no extension)"
      break
    done
    if ((found == 0)); then
      echo "not found git-prompt"
    fi
  fi

  if ! HasGitCompletion; then
    local gc="${GIT_LOCAL}/git-completion.bash"
    if [[ -r "$gc" ]]; then
      # shellcheck disable=SC1090
      source "$gc"
      echo "loaded git-completion"
    else
      echo "not found git-completion (skip)"
    fi
  fi

}

# usage: _InstallGitHelper <local_filename> <remote_filename>
_InstallGitHelper()
{
  local target="$1"
  local remote="$2"
  local from="https://raw.githubusercontent.com/git/git/master/contrib/completion"

  mkdir -p "${GIT_LOCAL}"

  local found
  found="$(find "${GIT_FILE_LOCATION[@]}" -type f -name "${remote}" 2> /dev/null | head -n 1)"

  if [[ -n "$found" ]]; then
    echo "copy: ${found} -> ${GIT_LOCAL}/${target}"
    cp -f "$found" "${GIT_LOCAL}/${target}"
  else
    echo "download: ${remote}"
    curl -fsSL -o "${GIT_LOCAL}/${target}" "${from}/${remote}"
  fi
}

## GitPrompt
HasGitPrompt()
{
  # __git_ps1 が定義済みなら git-prompt.sh は読み込まれている
  if [[ "$(type -t __git_ps1 2> /dev/null)" == "function" ]]; then
    return 0
  fi
  return 1
}

InstallGitPrompt()
{
  _InstallGitHelper "git-prompt.sh" "git-prompt.sh"
}

## Git Completion

# 0 (true) ならすでに定義済み
HasGitCompletion()
{
  if [[ "$-" != *i* ]]; then
    return 0
  fi
  if complete -p git &> /dev/null; then
    # echo "skip: git completion already set"
    return 0
  fi
  # 代表的な関数が存在する場合も不要
  if [[ "$(type -t __git_complete 2> /dev/null)" == "function" ]] \
    || [[ "$(type -t _git 2> /dev/null)" == "function" ]]; then
    # echo "skip: git completion functions already present"
    return 0
  fi

  return 1
}

InstallGitCompletion()
{
  _InstallGitHelper "git-completion.bash" "git-completion.bash"
}
