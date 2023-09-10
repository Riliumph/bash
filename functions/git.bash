GIT_LOCAL="./local/git"

LoadGitFiles()
{
  if [ -e "${GIT_LOCAL}/git-prompt.sh" ]; then
    source "${GIT_LOCAL}/git-prompt.sh"
  elif [ -e "${GIT_LOCAL}/git-prompt" ]; then
    source "${GIT_LOCAL}/git-prompt"
  fi
  if [ -e "${GIT_LOCAL}/git-completion.bash" ]; then
    source "${GIT_LOCAL}/git-completion.bash"
  fi
}
