docker-rmi()
{
  while true; do
    image=$(
      docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}' \
        | peco
    )

    [ -z "$image" ] && break

    id=$(awk '{print $3}' <<< "$image")

    # ヘッダ行なら再選択
    [ "$id" = "IMAGE" ] && continue

    docker rmi "$id" || break
  done
}

docker-rm()
{
  while true; do
    container=$(
      docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}' \
        | peco
    )

    [ -z "$container" ] && break

    id=$(awk '{print $1}' <<< "$container")

    # ヘッダ行
    [ "$id" = "CONTAINER" ] && continue

    running=$(docker inspect -f '{{.State.Running}}' "$id")

    if [ "$running" = "true" ]; then
      printf "Container '%s' is running. Remove it? [y/N] " "$id"
      read -r answer

      case "$answer" in
        y | Y | yes | YES) ;;
        *) continue ;;
      esac
    fi

    docker rm "$id" || break
  done
}
