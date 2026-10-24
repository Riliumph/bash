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
  local author add del line
  local rows=""

  declare -A commits
  declare -A added
  declare -A deleted

  while IFS= read -r line; do
    if [[ $line == @@@* ]]; then
      author=${line#@@@}
      ((commits["$author"]++))
      continue
    fi

    read -r add del _ <<< "$line"

    [[ $add =~ ^[0-9]+$ ]] || continue
    [[ $del =~ ^[0-9]+$ ]] || continue

    ((added["$author"] += add))
    ((deleted["$author"] += del))
  done < <(git log --all --format='@@@%aN' --numstat)

  for author in "${!commits[@]}"; do
    rows+="${author}\t${commits[$author]}\t${added[$author]:-0}\t${deleted[$author]:-0}"$'\n'
  done

  (
    echo -e "Author\tCommits\tAdded\tDeleted"
    echo -e "$rows" | sort -t $'\t' -k2,2nr # sort by [Commits]
  ) | column -t -s $'\t'
}

git-stat-files()
{
  local limit="${1:-$1}"
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
