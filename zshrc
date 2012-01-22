export EDITOR=vim

test -f ~/.zshrc.local && source ~/.zshrc.local

# no spelling correction on:
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias ls='ls --color'

# Emacs-style commandline editing
bindkey -e

# zsh completion magic:
zstyle ':completion:*' completer _list _expand _complete _ignored _match _prefix
zstyle ':completion:*' condition 'NUMERIC != 1'
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{a-z}={A-Z} l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 1

autoload -U compinit
compinit

# auto quote urls when needed
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# setup prompt and colors
autoload -U colors
colors

export PROMPT="%j %{$fg[blue]%}%m%{$reset_color%}:%{$fg_bold[yellow]%}%30<..<%~%{$reset_color%}> "

export HISTSIZE=1000000000
export HISTFILE=~/.zsh_history
export SAVEHIST=300000000
