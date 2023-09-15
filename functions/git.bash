GIT_LOCAL="$BASH_ROOT/.local/git"
GIT_FILE_LOCATION=("/usr/share")              # Default
GIT_FILE_LOCATION+=("/usr/local/opt")         # for macOS
GIT_FILE_LOCATION+=("/etc/bash_completion.d") # for ubuntu

LoadGitFiles()
{
  if [ -e "${GIT_LOCAL}/git-prompt.sh" ]; then
    source "${GIT_LOCAL}/git-prompt.sh"
  elif [ -e "${GIT_LOCAL}/git-prompt" ]; then
    source "${GIT_LOCAL}/git-prompt"
  fi
  if [ -e "${GIT_LOCAL}/git-completion.bash" ]; then
    source "${GIT_LOCAL}/git-completion.bash"

InstallGitPrompt()
{
  mkdir -p "${GIT_LOCAL}"
  # Search git prompt
  mapfile -t gitprompts < <(find "${GIT_FILE_LOCATION[@]}" -type f -name "git-prompt*" 2> /dev/null)
  if (("${#gitprompts[@]}" == 0)); then
    # Download mode
    local -r from="https://raw.githubusercontent.com/git/git/master/contrib/completion"
    curl -o "${GIT_LOCAL}/git-prompt.sh" "${from}/git-prompt.sh"
  else
    # local copy mode
    cp -f "${gitprompts[0]}" "${GIT_LOCAL}/git-prompt.sh"
  fi
}

InstallGitCompletion()
{
  mkdir -p "${GIT_LOCAL}"
  # Search git prompt
  mapfile -t gitprompts < <(find "${GIT_FILE_LOCATION[@]}" -type f -name "git-completion.bash" 2> /dev/null)
  if (("${#gitprompts[@]}" == 0)); then
    # Download mode
    local -r from="https://raw.githubusercontent.com/git/git/master/contrib/completion"
    curl -o "${GIT_LOCAL}/git-completion.bash" "${from}/git-completion.bash" 2> /dev/null
  else
    # local copy mode
    cp -f "${gitprompts[0]}" "${GIT_LOCAL}/git-completion.bash"
  fi
}
