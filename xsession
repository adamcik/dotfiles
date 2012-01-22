test -f ~/.xsession.local && source ~/.xsession.local

# Load xmodmap changes and xresources changes.
test -f ~/.Xmodmap    && xmodmap ~/.Xmodmap
test -f ~/.Xresources && xrdb -merge ~/.Xresources

# Tell gtk to use x input method
export GTK_IM_MODULE=xim

gnome-settings-daemon &
gnome-screensaver     &

# Only bother with these if running on a laptop.
laptop-detect && gnome-power-manager &
laptop-detect && nm-applet           &

# Launch awesome window manager :-)
exec awesome
