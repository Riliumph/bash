git-stat-summary()
{
  local commits
  local added=0
  local deleted=0

  commits=$(git rev-list --count HEAD)

  while read -r add del _; do
    [[ -z "$add" || -z "$del" ]] && continue
    ((added += add))
    ((deleted += del))
  done < <(
    git log --numstat --format=""
  )

  (
    echo -e "Metric\tValue"
    echo -e "Commits\t$commits"
    echo -e "Added\t$added"
    echo -e "Deleted\t$deleted"
  ) | column -t -s $'\t'
}
