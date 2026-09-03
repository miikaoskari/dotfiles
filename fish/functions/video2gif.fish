function video2gif --description 'Convert a video to a GIF no larger than the source file'
    set -l input $argv[1]
    set -l output $argv[2]
    
    if test -z "$input"
        echo "Usage: video2gif <input video> [output.gif]"
        return 1
    end
    
    if not test -f "$input"
        echo "File not found: $input"
        return 1
    end
    
    if test -z "$output"
        set output (string replace -r '\.[^.]*$' '.gif' -- $input)
    end
    
    function _fsize
        stat -c%s "$argv[1]" 2>/dev/null; or stat -f%z "$argv[1]"
    end
    
    set -l target_size (_fsize "$input")
    
    set -l fps 15
    set -l width 480
    
    for attempt in 1 2 3 4 5
        ffmpeg -y -hwaccel auto -i "$input" -an \
                        -filter_complex "fps=$fps,scale=$width:-1:flags=lanczos,split[a][b];[a]palettegen=max_colors=192[p];[b][p]paletteuse=dither=bayer" \
                        "$output" &>/dev/null
        
        set -l gif_size (_fsize "$output")
        
        echo "Attempt $attempt: fps=$fps width=$width -> "(math $gif_size / 1024 / 1024)"MB (target <= "(math $target_size / 1024 / 1024)"MB)"
        
        if test $gif_size -le $target_size
            echo "✅ Done: $output ("(math $gif_size / 1024)" KB)"
            functions -e _fsize
            return 0
        end
        
        set fps (math "$fps - 3")
        set width (math "$width - 80")
        test $fps -lt 5; and set fps 5
        test $width -lt 160; and set width 160
    end
    
    echo "⚠️ Couldn't get under target size after 5 tries; last attempt saved at $output"
    functions -e _fsize
end
