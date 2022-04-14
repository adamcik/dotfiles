export EDITOR=vim
export TERMINAL=urxvt
export MOSH_SERVER_NETWORK_TMOUT=2592000
export LANG=en_DK.utf8

# Tell gtk to use x input method
export GTK_IM_MODULE=xim

export PATH=~/.local/bin:$PATH

test -f ~/.profile.local && source ~/.profile.local

. "$HOME/.cargo/env"
