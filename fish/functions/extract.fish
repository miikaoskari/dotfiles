function extract --description 'Extract common archive formats, optionally into a chosen output directory'
    argparse 'o/output=' -- $argv
    or return 1

    if test (count $argv) -eq 0
        echo "Usage: extract [-o|--output DIR] <archive> [archive2 ...]"
        return 1
    end

    set -l outdir "."
    if set -q _flag_output
        set outdir $_flag_output
        if not test -d $outdir
            mkdir -p $outdir
            or return 1
        end
    end

    for file in $argv
        if not test -f $file
            echo "extract: file not found: $file"
            continue
        end

        set -l lower (string lower -- $file)
        set -l base (path basename -- $file)

        switch $lower
            case '*.tar.gz' '*.tgz'
                tar -xzf $file -C $outdir
            case '*.tar.bz2' '*.tbz2'
                tar -xjf $file -C $outdir
            case '*.tar.xz' '*.txz'
                tar -xJf $file -C $outdir
            case '*.tar.zst' '*.tzst'
                tar --zstd -xf $file -C $outdir
            case '*.tar'
                tar -xf $file -C $outdir
            case '*.zip'
                unzip -o -q $file -d $outdir
            case '*.rar'
                unrar x -o+ $file $outdir/
            case '*.7z'
                7z x $file -o"$outdir" -y >/dev/null
            case '*.gz'
                gunzip -k -c $file >"$outdir/"(string replace -r '\.gz$' '' -- $base)
            case '*.bz2'
                bunzip2 -k -c $file >"$outdir/"(string replace -r '\.bz2$' '' -- $base)
            case '*.xz'
                unxz -k -c $file >"$outdir/"(string replace -r '\.xz$' '' -- $base)
            case '*.zst'
                unzstd -k -c $file >"$outdir/"(string replace -r '\.zst$' '' -- $base)
            case '*.z'
                uncompress -c $file >"$outdir/"(string replace -r '\.Z$' '' -- $base)
            case '*'
                echo "extract: unsupported format: $file"
                continue
        end

        if test $status -eq 0
            echo "Extracted $file -> $outdir"
        else
            echo "Failed to extract $file"
        end
    end
end
