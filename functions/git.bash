LoadGitFiles()
{
  if [ -e "${GIT_CONFIG_DIR}/git-prompt.sh" ]; then
    # echo "Loding git-prompt.sh ..."
    source "${GIT_CONFIG_DIR}/git-prompt.sh"
  elif [ -e "${GIT_CONFIG_DIR}/git-prompt" ]; then
    # echo "Loding git-prompt ..."
    source "${GIT_CONFIG_DIR}/git-prompt"
  else
    echo "not found git-prompt"
  fi
  if [ -e "${GIT_CONFIG_DIR}/git-completion.bash" ]; then
    # echo "Loding git-completion.bash ..."
    source "${GIT_CONFIG_DIR}/git-completion.bash"
  else
    echo "not found git-completion"
  fi
}

InstallGitPrompt()
{
  mkdir -p "${GIT_CONFIG_DIR}"
  # Search git prompt
  mapfile -t gitprompts < <(find "${GIT_FILE_LOCATION[@]}" -type f -name "git-prompt*" 2> /dev/null)
  if (("${#gitprompts[@]}" == 0)); then
    echo "Download mode"
    local -r from="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
    local -r to="${GIT_CONFIG_DIR}/git-prompt.sh"
    printf "installing ...\n %s\n -> %s\n" "${from}" "${to}"
    curl -o "${to}" "${from}"
  else
    echo "Local copy mode"
    local -r from="${gitprompts[0]}"
    local -r to="${GIT_CONFIG_DIR}/git-prompt.sh"
    printf "installing ...\n %s\n -> %s\n" "${from}" "${to}"
    cp -f "${from}" "${to}"
  fi
}

InstallGitCompletion()
{
  mkdir -p "${GIT_CONFIG_DIR}"
  # Search git prompt
  mapfile -t gitprompts < <(find "${GIT_FILE_LOCATION[@]}" -type f -name "git-completion.bash" 2> /dev/null)
  if (("${#gitprompts[@]}" == 0)); then
    echo "Download mode"
    local -r from="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
    local -r to="${GIT_CONFIG_DIR}/git-completion.bash"
    printf "installing ...\n %s\n -> %s\n" "${from}" "${to}"
    curl -o "${to}" "${from}"
  else
    echo "Local copy mode"
    local -r from="${gitprompts[0]}"
    local -r to="${GIT_CONFIG_DIR}/git-completion.bash"
    printf "installing ...\n %s\n -> %s\n" "${from}" "${to}"
    cp -f "${from}" "${to}"
  fi
}
