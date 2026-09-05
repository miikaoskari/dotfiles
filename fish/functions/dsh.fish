function dsh --description 'Pick a running container with fzf and open a shell in it'
    set -l container (docker ps --format '{{.Names}}\t{{.Image}}' | fzf | string split -f1 \t)

    if test -z "$container"
        return 1
    end

    set -l shell sh
    docker exec $container which bash >/dev/null 2>&1
    and set shell bash

    docker exec -it $container $shell
end
