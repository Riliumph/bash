docker-rmi()
{
  while true; do
    images=$(
      docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}' \
        | peco
    )

    [ -z "$images" ] && break

    while IFS= read -r image; do
      id=$(awk '{print $3}' <<< "$image")

      # ヘッダ行ならスキップ
      [ "$id" = "IMAGE" ] && continue

      docker rmi "$id" || break
    done <<< "$images"
  done
}

docker-rm()
{
  while true; do
    containers=$(
      docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}' \
        | peco
    )

    [ -z "$containers" ] && break

    while IFS= read -r container; do
      id=$(awk '{print $1}' <<< "$container")

      # ヘッダ行
      [ "$id" = "CONTAINER" ] && continue

      running=$(docker inspect -f '{{.State.Running}}' "$id")

      if [ "$running" = "true" ]; then
        printf "Container '%s' is running. Remove it? [y/N] " "$id"
        ## Explicitly read from the controlling TTY.
        # Without /dev/tty, read consumes the here-string input (<<< "$containers")
        # instead of waiting for user input.
        read -r answer < /dev/tty
        case "$answer" in
          y | Y | yes | YES)
            docker rm -f "$id" || break
            continue
            ;;
          *) continue ;;
        esac
      fi
      docker rm "$id" || break
    done <<< "$containers"
  done
}
