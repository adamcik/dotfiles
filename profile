export EDITOR=vim
export TERMINAL=urxvt
export MOSH_SERVER_NETWORK_TMOUT=2592000

# Tell gtk to use x input method
export GTK_IM_MODULE=xim

test -f ~/.profile.local && source ~/.profile.local
