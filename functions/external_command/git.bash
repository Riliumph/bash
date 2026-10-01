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

git-stat-by-authors()
{
  local rows=""
  local author
  local commits
  local added
  local deleted

  while read -r author; do
    commits=$(git rev-list --count --all --author="$author")

    added=0
    deleted=0

    while read -r add del _; do
      [[ -z "$add" || -z "$del" ]] && continue
      ((added += add))
      ((deleted += del))
    done < <(git log --author="$author" --numstat --format="")

    rows+="${author}\t${commits}\t${added}\t${deleted}"$'\n'
  done < <(git shortlog -s -n --all | sed 's/^[[:space:]]*[0-9]*[[:space:]]*//')

  (
    echo -e "Author\tCommits\tAdded\tDeleted"
    echo -e "$rows"
  ) | column -t -s $'\t'
}

git-stat-files()
{
  local limit="${1:-20}"
  local rows

  rows=$(
    git log --numstat --format="" \
      | awk '
          NF==3 {
            files[$3] += $1 + $2
          }
          END {
            for (f in files)
              print files[f] "\t" f
          }
        ' \
      | sort -nr \
      | head -n "$limit"
  )

  (
    echo -e "Changes\tFile"
    echo "$rows"
  ) | column -t -s $'\t'
}
