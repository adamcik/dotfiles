export EDITOR=vim
export TERMINAL=urxvt

if [ -n "$DISPLAY" ]; then
    # Tell gtk to use x input method
    export GTK_IM_MODULE=xim

    # Load xmodmap changes and xresources changes.
    test -f ~/.Xmodmap    && xmodmap ~/.Xmodmap
    test -f ~/.Xresources && xrdb -merge ~/.Xresources
fi

test -f ~/.profile.local && source ~/.profile.local
