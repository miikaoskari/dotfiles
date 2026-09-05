function fkill --description 'Pick one or more processes with fzf and kill them (pass -9 for SIGKILL)'
    set -l sig TERM
    if contains -- -9 $argv
        set sig KILL
    end

    set -l pids (ps -eo pid,ppid,user,%cpu,%mem,comm | fzf --header-lines=1 --multi | awk '{print $1}')

    if test -z "$pids"
        return 1
    end

    for pid in $pids
        kill -s $sig $pid
        and echo "Killed $pid (SIG$sig)"
    end
end
