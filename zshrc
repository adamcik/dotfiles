test -f ~/.zshrc.local && source ~/.zshrc.local

# no spelling correction on:
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias ls='ls --color'
alias ack='ack-grep'

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

# Add a bunch of helpers if we are running in X.
if [ -n "$DISPLAY" ]; then
  function disable-caps {
    python -c 'from ctypes import *; X11 = cdll.LoadLibrary("libX11.so.6"); display = X11.XOpenDisplay(None); X11.XkbLockModifiers(display, c_uint(0x0100), c_uint(2), c_uint(0)); X11.XCloseDisplay(display)'
  }

  function toggle-trackpad {
    synclient TouchpadOff=$(synclient -l | grep TouchpadOff | awk '{print !$3}')
  }

  function _dbus-upower {
    dbus-send --system --print-reply --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.$1
  }

  function suspend {
    _dbus-upower Suspend
  }

  function hibernate {
    _dbus-upower Hibernate
  }
fi
