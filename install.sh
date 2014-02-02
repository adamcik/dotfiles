#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

# Get rid of existing profile as we want our own.
mv ~/.profile ~/.profile.bak

for file in profile muttrc vimrc zshrc Xresources; do
  test -f ~/.$file || ln -s $BASEDIR/$file ~/.$file
done

test -d ~/.config/i3        || mkdir -p ~/.config/i3
test -f ~/.config/i3/config || ln -s $BASEDIR/i3.config ~/.config/i3/config

test -d ~/.config/i3status        || mkdir -p ~/.config/i3status
test -f ~/.config/i3status/config || ln -s $BASEDIR/i3status.config ~/.config/i3status/config

echo Remember to run: aptitude install ack-grep apt-file bind9-host build-essential dnsutils git ipython less mosh screen vim zsh
echo Remember to run: aptitude install i3 rxvt-unicode xfonts-terminus redshift xautolock
