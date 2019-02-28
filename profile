export EDITOR=vim
export TERMINAL=urxvt
export LANG=en_DK.utf8

# Tell gtk to use x input method
export GTK_IM_MODULE=xim

test -f ~/.profile.local && source ~/.profile.local
