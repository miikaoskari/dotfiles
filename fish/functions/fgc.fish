function fgc
    git checkout (git branch --all | sed 's/^\* //' | fzf | tr -d ' ')
end
