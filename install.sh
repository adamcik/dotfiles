#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

for file in profile muttrc vimrc zshrc Xresources; do
  test -f ~/.$file || ln -s $BASEDIR/$file ~/.$file
done

test -d ~/.config/i3        || mkdir -p ~/.config/i3
test -f ~/.config/i3/config || ln -s $BASEDIR/i3.config ~/.config/i3/config

test -d ~/.config/i3status        || mkdir -p ~/.config/i3status
test -f ~/.config/i3status/config || ln -s $BASEDIR/i3status.config ~/.config/i3status/config

echo Remeber to run: aptitude install apt-file bind9-host build-essential dnsutils git i3 ipython less mosh rxvt-unicode screen vim xfonts-terminus zsh redshift xautolock
