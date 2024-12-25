#!/bin/bash
# Install dotfiles as symlinks to this repo.

# Private defaults and hardened bash
set -o nounset
set -o errexit
set -o pipefail
umask 077

BASEDIR="$(readlink -m "$(dirname "$0")")"
RUN="" # Set to echo for dry run

symlink() {
	DIRECTORY="$(dirname "$1")"
	TARGET="$(realpath --no-symlinks "${BASEDIR}/$2")"
	LINK_NAME="$(realpath --no-symlinks "$1")"

	# Create directory if missing:
	test -d "${DIRECTORY}" || mkdir -p "${DIRECTORY}"

	# Remove stray backup:
	test -L "${LINK_NAME}.backup" -a "$(readlink "${LINK_NAME}.backup")" = "$(readlink "${LINK_NAME}")" &&
		${RUN} rm "${LINK_NAME}.backup"

	# Backup before replacing:
	test -L "${LINK_NAME}" ||
		${RUN} mv "${LINK_NAME}" "${LINK_NAME}.backup"

	printf "~/%-40s → ~/%s\n" \
		"$(realpath --relative-base="$HOME" --no-symlinks "${LINK_NAME}")" \
		"$(realpath --relative-base="$HOME" --no-symlinks "${TARGET}")"
	${RUN} ln --no-dereference --symbolic --force "${TARGET}" "${LINK_NAME}"
}

echo Setting up links:
echo

symlink ~/.config/fish/config.fish ./fish
symlink ~/.config/fish/functions/fish_prompt.fish ./fish_prompt
symlink ~/.config/fish/functions/fish_title.fish ./fish_title
symlink ~/.gitconfig ./gitconfig
symlink ~/.profile ./profile
symlink ~/.screenrc ./screenrc
symlink ~/.ssh/config ./ssh_config
symlink ~/.ssh/rc ./ssh_rc
symlink ~/.tmux.conf ./tmux
symlink ~/.vimrc ./vimrc
symlink ~/.vim/colors/material.vim ./vim_material
symlink ~/.zshrc ./zshrc

${RUN} chmod 700 ~/.ssh
${RUN} chmod 700 ~/.gnupg

echo
echo Remember to run:
echo
echo $ apt install ack-grep bind9-host dnsutils git ipython3 less mosh screen vim zsh tmux
echo $ dpkg-reconfigure locales
echo

if test -z "${SSH_TTY:-}"; then
	echo Setting up local links:
	echo
	symlink ~/.config/i3/config ./i3
	symlink ~/.config/i3status/config ./i3status
	symlink ~/.config/kitty/kitty.conf ./kitty
	symlink ~/.gnupg/gpg-agent.conf ./gpg-agent
	symlink ~/.gnupg/gpg.conf ./gpg
	symlink ~/.local/bin/input-event ./bin/input-event
	symlink ~/.Xresources ./xresources

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
