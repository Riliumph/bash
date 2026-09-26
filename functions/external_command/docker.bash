docker-rmi()
{
  while true; do
    image=$(docker images --format '{{.Repository}}:{{.Tag}}\t{{.ID}}' | peco)

    [ -z "$image" ] && break

    id=$(echo "$image" | awk '{print $2}')

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
