#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

# Get rid of existing profile as we want our own.
test -f ~/.profile && test -L ~/.profile || mv ~/.profile ~/.profile.bak

symlink() {
test -d $(dirname $1) || mkdir -p $(dirname $1)
test -L $1 || ln -s $BASEDIR/$2 $1
}

symlink ~/.config/i3/config       i3.config
symlink ~/.config/i3status/config i3status.config
symlink ~/.config/kitty/config    kitty.conf
symlink ~/.gitconfig              gitconfig
symlink ~/.gnupg/gpg-agent.conf   gpg-agent.conf
symlink ~/.gnupg/gpg.conf         gpg.conf
symlink ~/.local/bin/input-event  input-event
symlink ~/.muttrc                 muttrc
symlink ~/.profile                profile
symlink ~/.screenrc               screenrc
symlink ~/.ssh/config             ssh_config
symlink ~/.ssh/rc                 ssh_rc
symlink ~/.vimrc                  vimrc
symlink ~/.zshrc                  zshrc
symlink ~/.Xresources             Xresources

echo Remember to run: aptitude install ack-grep bind9-host dnsutils git ipython less mosh screen vim zsh
echo Remember to run: aptitude install i3 kitty redshift xss-lock xautolock pavucontrol kitty inputplug
echo Remember to run: aptitude install scdaemon gnupg gnupg-agent libccid pinentry-curses dbus-user-session
echo Remember to run: gsettings set org.gnome.settings-daemon.plugins.keyboard active false
echo Remember to run: 'gpg2 --card-status\n fetch\n^D; gpg2 --edit-key ...\ntrust\n5\n^D'
echo Remember to run: dpkg-reconfigure locales

echo And add '[Qt]\\nstyle=GTK+' to .config/Trolltech.conf
