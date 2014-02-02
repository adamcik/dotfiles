export EDITOR=vim
export TERMINAL=urxvt

# Tell gtk to use x input method
export GTK_IM_MODULE=xim

eval `keychain --eval --clear --inherit local --timeout 10 ~/.ssh/id_rsa`

test -f ~/.profile.local && source ~/.profile.local
