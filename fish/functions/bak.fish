function bak --description 'Back up a file or directory as <name>.bak.<timestamp>'
    if test (count $argv) -eq 0
        echo "Usage: bak <file> [file2 ...]"
        return 1
    end

    for file in $argv
        if not test -e $file
            echo "bak: file not found: $file"
            continue
        end

        set -l stamp (date +%Y%m%d%H%M%S)
        set -l dest "$file.bak.$stamp"
        set -l n 1
        while test -e $dest
            set dest "$file.bak.$stamp.$n"
            set n (math $n + 1)
        end

        cp -a $file $dest
        and echo "Backed up $file -> $dest"
    end
end
