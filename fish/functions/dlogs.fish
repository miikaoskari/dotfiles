function dlogs --description 'Pick a container with fzf and tail its logs'
    set -l container (docker ps -a --format '{{.Names}}\t{{.Image}}' | fzf | string split -f1 \t)

    if test -z "$container"
        return 1
    end

    docker logs -f --tail 200 $container
end
