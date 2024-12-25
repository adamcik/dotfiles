#!/bin/bash
# Install dotfiles as symlinks to this repo.

# Private defaults and hardened bash
set -o nounset
set -o errexit
set -o pipefail
umask 077

# TODO: Switch to more portable way of getting BASEDIR?
BASEDIR="$(realpath "$(dirname "$0")")"
RUN="" # Set to echo for dry run

symlink() {
	if [ "$(expr "$(realpath "$2")" : "${BASEDIR}")" -eq 0 ]; then
		echo "$2 ($(realpath "$1")) is not in ${BASEDIR}"
		exit 1
	fi

	# TODO: Check that $2 is inside $BASEDIR
	if [ -d "$2" ]; then
		while IFS= read -d '' -r file; do
			target="$(realpath --relative-base="${BASEDIR}" "${file}" | cut -d/ -f2-)"
			_symlink \
				"$(realpath --no-symlinks "$1/${target}")" \
				"$(realpath --no-symlinks "${file}")"
		done < <(find "$2" -type f -print0)
	else
		_symlink "$1" "$(realpath --no-symlinks "${BASEDIR}/$2")"
	fi
}

_symlink() {
	LINK_NAME="$1"
	TARGET="$2"
	DIRECTORY="$(dirname "${LINK_NAME}")"

	# Create directory if missing:
	test -d "${DIRECTORY}" || ${RUN} mkdir -p "${DIRECTORY}"

	# Backup before replacing:
	if [ ! -L "${LINK_NAME}" ] && [ -f "${LINK_NAME}" ]; then
		diff -u "${LINK_NAME}" "${TARGET}" ||
			${RUN} mv "${LINK_NAME}" "${LINK_NAME}.backup"
	fi

	printf "~/%-40s → ~/%s\n" \
		"$(realpath --relative-base="$HOME" --no-symlinks "${LINK_NAME}")" \
		"$(realpath --relative-base="$HOME" --no-symlinks "${TARGET}")"
	${RUN} ln --no-dereference --symbolic --force "${TARGET}" "${LINK_NAME}"
}

completion() {
	PROGRAM="$1"
	printf "$ %-40s → ~/%s\n" "$*" ".config/fish/completions/${PROGRAM}.fish"
	type -p "${PROGRAM}" >/dev/null && "$@" >"${HOME}/.config/fish/completions/${PROGRAM}.fish"
}

echo Setting up links:
echo

symlink ~/.config/fish/ ./fish/
symlink ~/.ssh/ ./ssh/
symlink ~/.vim/ ./vim/
echo
symlink ~/.config/jj/config.toml jj.toml
symlink ~/.gitconfig ./gitconfig
symlink ~/.profile ./profile
symlink ~/.screenrc ./screenrc
symlink ~/.tmux.conf ./tmux
symlink ~/.vimrc ./vimrc
symlink ~/.zshrc ./zshrc

echo
echo Generating completions:
echo

completion av completion fish
completion gh completion -s fish
completion jj util completion fish
completion poetry completions fish

echo
echo Linking local bin:
echo

for file in ./bin/*; do
	test -f "${file}" && symlink "${HOME}/.local/${file}" "${file}"
done

echo
echo Remember to run:
echo
echo $ apt install ack-grep bind9-host dnsutils git ipython3 less mosh screen vim zsh
echo $ apt install fish tmux neovim ripgrep
echo $ dpkg-reconfigure locales
echo

# TODO: mise

if test -z "${SSH_TTY:-}"; then
	echo Setting up local links:
	echo
	symlink ~/.config/i3/config ./i3
	symlink ~/.config/i3status/config ./i3status
	symlink ~/.config/kitty/kitty.conf ./kitty
	symlink ~/.Xresources ./xresources

	symlink ~/.config/foot/foot.ini ./foot.ini
	symlink ~/.config/kanshi/config ./kanshi
	symlink ~/.config/sway/config ./sway

	symlink ~/.gnupg/gpg-agent.conf ./gpg-agent
	symlink ~/.gnupg/gpg.conf ./gpg

	echo
	echo Remember to run:
	echo
	echo $ apt install i3 kitty redshift xss-lock xautolock pavucontrol kitty inputplug
	echo $ apt install sway waybar foot swayidle fonts-firacode light kanshi ddcutil
	echo $ apt install scdaemon gnupg gnupg-agent libccid pinentry-curses dbus-user-session
	echo
	echo $ gsettings set org.gnome.settings-daemon.plugins.keyboard active false
	echo
	printf "$ gpg2 --edit-card\nfetch\n^D\n"
	printf "$ gpg2 --edit-key 9714F97B0CBEE929\ntrust\n^D\n"
	echo
fi

${RUN} chmod 700 ~/.ssh
${RUN} chmod 700 ~/.gnupg
