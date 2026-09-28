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
    container=$(docker ps -a --format '{{.Names}}\t{{.Image}}\t{{.Status}}' | peco)

    [ -z "$container" ] && break

    name=$(echo "$container" | awk '{print $1}')

    running=$(docker inspect -f '{{.State.Running}}' "$name")

    if [ "$running" = "true" ]; then
      printf "Container '%s' is running. Remove it? [y/N] " "$name"
      read -r answer

      case "$answer" in
        y | Y | yes | YES) ;;
        *)
          continue
          ;;
      esac
    fi

    docker rm "$name" || break
  done
}
