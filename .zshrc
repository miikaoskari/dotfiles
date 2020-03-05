# miika's config for zsh :--)

# enable history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# vi mode
bindkey -v

zstyle :compinstall filename '/home/miika/.zshrc'

# enable colors
autoload -U colors && colors

# autocomplete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # adds hidden files to autocompletion

# prompt
#PS1="%B%{$fg[magenta]%}%~->$reset_color% %b" this prompt has weird errors with autocompletion do NOT use
PS1="%{$fg_bold[green]%}%~ ->%{$reset_color%} ${VIMODE} "

# Aliases
alias ls='ls --color=auto' # enables colors on grep output
alias grep='grep --color=auto' # enables colors on grep output
alias grpe='grep --color=auto'

# exports
export PF_INFO="ascii title kernel shell pkgs wm" # pfetch changes
export PF_ASCII="kiss" # pfetch changes
export TERM=xterm-256color # enables lightline.vim colors inside tmux session

# cowsay startup message :D
fortune | cowsay
