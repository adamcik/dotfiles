#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

# Get rid of existing profile as we want our own.
test -f ~/.profile && test -L ~/.profile || mv ~/.profile ~/.profile.bak

symlink() {
DIRECTORY=$(dirname $1)
TARGET=$BASEDIR/$2
LINK_NAME=$1
test -d $DIRECTORY || mkdir -p $DIRECTORY
printf "%-40s --> %s\n" $(realpath --relative-base=$HOME --no-symlinks $LINK_NAME) $(realpath --relative-base=$HOME $TARGET)
ln -nsf $TARGET $LINK_NAME
}

echo Setting up links:
echo

symlink ~/.config/fish/fish.config                fish
symlink ~/.config/fish/functions/fish_prompt.fish fish_prompt
symlink ~/.config/fish/functions/fish_title.fish  fish_title
symlink ~/.config/i3/config                       i3
symlink ~/.config/i3status/config                 i3status
symlink ~/.config/kitty/kitty.conf                kitty
symlink ~/.gitconfig                              gitconfig
symlink ~/.gnupg/gpg-agent.conf                   gpg-agent
symlink ~/.gnupg/gpg.conf                         gpg
symlink ~/.local/bin/input-event                  input-event
symlink ~/.muttrc                                 muttrc
symlink ~/.profile                                profile
symlink ~/.screenrc                               screenrc
symlink ~/.ssh/config                             ssh_config
symlink ~/.ssh/rc                                 ssh_rc
symlink ~/.vimrc                                  vimrc
symlink ~/.vim/colors/material.vim                vim_material
symlink ~/.zshrc                                  zshrc
symlink ~/.Xresources                             xresources

chmod 700 ~/.gnupg
chmod 700 ~/.ssh

echo
echo Remember to run:
echo aptitude install ack-grep bind9-host dnsutils git ipython less mosh screen vim zsh
echo aptitude install i3 kitty redshift xss-lock xautolock pavucontrol kitty inputplug
echo aptitude install scdaemon gnupg gnupg-agent libccid pinentry-curses dbus-user-session
echo gsettings set org.gnome.settings-daemon.plugins.keyboard active false
echo dpkg-reconfigure locales
echo
echo 'gpg2 --card-status\n fetch\n^D; gpg2 --edit-key ...\ntrust\n5\n^D'
echo
echo And add '[Qt]\\nstyle=GTK+' to .config/Trolltech.conf
echo
