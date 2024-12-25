#!/bin/bash
# Install dotfiles as symlinks to this repo.

# Private defaults and hardened bash
set -o nounset
set -o errexit
set -o pipefail
umask 077

BASEDIR="$(readlink -m "$(dirname "$0")")"

symlink() {
	DIRECTORY=$(dirname $1)
	TARGET=$BASEDIR/$2
	LINK_NAME=$1
	test -d $DIRECTORY || mkdir -p $DIRECTORY
	printf "%-40s → %s\n" $(realpath --relative-base=$HOME --no-symlinks $LINK_NAME) $2
	ln -nsf $TARGET $LINK_NAME
}

echo Setting up links:
echo

symlink ~/.config/fish/config.fish fish
symlink ~/.config/fish/functions/fish_prompt.fish fish_prompt
symlink ~/.config/fish/functions/fish_title.fish fish_title
symlink ~/.gitconfig gitconfig
symlink ~/.profile profile
symlink ~/.screenrc screenrc
symlink ~/.ssh/config ssh_config
symlink ~/.ssh/rc ssh_rc
symlink ~/.tmux.conf tmux
symlink ~/.vimrc vimrc
symlink ~/.vim/colors/material.vim vim_material
symlink ~/.zshrc zshrc

chmod 700 ~/.ssh

echo
echo Remember to run:
echo
echo $ apt install ack-grep bind9-host dnsutils git ipython3 less mosh screen vim zsh tmux
echo $ dpkg-reconfigure locales
echo

if test -z "${SSH_TTY:-}"; then
	echo Setting up local links:
	echo
	symlink ~/.config/i3/config i3
	symlink ~/.config/i3status/config i3status
	symlink ~/.config/kitty/kitty.conf kitty
	symlink ~/.gnupg/gpg-agent.conf gpg-agent
	symlink ~/.gnupg/gpg.conf gpg
	symlink ~/.local/bin/input-event bin/input-event
	symlink ~/.Xresources xresources

	chmod 700 ~/.gnupg

	echo
	echo Remember to run:
	echo
	echo $ apt install i3 kitty redshift xss-lock xautolock pavucontrol kitty inputplug
	echo $ apt install scdaemon gnupg gnupg-agent libccid pinentry-curses dbus-user-session
	echo
	echo $ gsettings set org.gnome.settings-daemon.plugins.keyboard active false
	echo
	printf "$ gpg2 --card-status\nfetch\n^D\n"
	printf "$ gpg2 --edit-key ...\ntrust\n\n^D\n"
	echo
fi
