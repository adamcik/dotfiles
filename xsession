test -f ~/.xsession.local && source ~/.xsession.local

gnome-settings-daemon &
gnome-screensaver     &

# Only bother with these if running on a laptop.
laptop-detect && gnome-power-manager &
laptop-detect && nm-applet           &

# Launch awesome window manager
exec ck-launch-session dbus-launch awesome
