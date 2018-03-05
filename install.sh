#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

# Get rid of existing profile as we want our own.
test -f ~/.profile && test -L ~/.profile || mv ~/.profile ~/.profile.bak

for file in profile muttrc vimrc zshrc Xresources gitconfig; do
  test -f ~/.$file || ln -s $BASEDIR/$file ~/.$file
done

test -d ~/.ssh        || mkdir -p ~/.ssh
test -f ~/.ssh/config || ln -s $BASEDIR/ssh_config ~/.ssh/config

test -d ~/.config/i3        || mkdir -p ~/.config/i3
test -f ~/.config/i3/config || ln -s $BASEDIR/i3.config ~/.config/i3/config

test -d ~/.config/i3status        || mkdir -p ~/.config/i3status
test -f ~/.config/i3status/config || ln -s $BASEDIR/i3status.config ~/.config/i3status/config

test -d ~/.gnupg/ || mkdir ~/.gnupg && chmod 700 ~/.gnupg
test -f ~/.gnupg/gpg.conf || ln -s $BASEDIR/gpg.conf ~/.gnupg/gpg.conf
test -f ~/.gnupg/gpg-agent.conf || ln -s $BASEDIR/gpg-agent.conf ~/.gnupg/gpg-agent.conf
test -f ~/.gnupg/sks-keyservers.netCA.pem || ln -s $BASEDIR/sks-keyservers.netCA.pem ~/.gnupg/sks-keyservers.netCA.pem

echo Remember to run: aptitude install ack-grep apt-file bind9-host build-essential dnsutils git ipython keychain less mosh screen vim zsh
echo Remember to run: aptitude install i3 rxvt-unicode xfonts-terminus redshift xautolock
echo Remember to run: aptitude install scdaemon gnupg gnupg-agent libccid pinentry-curses gnupg-curl
echo Remember to run: gsettings set org.gnome.settings-daemon.plugins.keyboard active false
echo Remember to run: 'gpg2 --card-status\n fetch\n^D; gpg2 --edit-key ...\ntrust\n5\n^D'

echo And add '[Qt]\\nstyle=GTK+' to .config/Trolltech.conf
