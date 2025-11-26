function fgc
    set branch (
        git for-each-ref --format='%(refname:short)' refs/heads |
        fzf --preview 'git log --color=always --graph --oneline --decorate --max-count=150 {1}'
    )

    if test -n "$branch"
        git checkout $branch
    end
end