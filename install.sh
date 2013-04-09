#!/bin/sh
# Install dotfiles as symlinks to this repo.

BASEDIR=$(readlink -m `dirname $0`)

for file in profile muttrc vimrc xsession zshrc XCompose Xmodmap Xresources; do
  test -f ~/.$file || ln -s $BASEDIR/$file ~/.$file
done

test -d ~/.config/awesome        || mkdir -p ~/.config/awesome
test -f ~/.config/awesome/rc.lua || ln -s $BASEDIR/awesome.lua ~/.config/awesome/rc.lua

test -d ~/.i3        || mkdir -p ~/.i3
test -f ~/.i3/config || ln -s $BASEDIR/i3.config ~/.i3/config


echo Remeber to run: aptitude install apt-file awesome bind9-host build-essential dnsutils git i3 less mosh rxvt-unicode screen vim xfonts-terminus zsh
