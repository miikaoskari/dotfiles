function serve
    if test -n "$argv[1]"
        set port $argv[1]
    else
        set port 8000
    end

    if test -n "$argv[2]"
        set dir $argv[2]
    else
        set dir "."
    end

    echo "Serving $dir at http://localhost:$port"
    python3 -m http.server $port --directory $dir
end

