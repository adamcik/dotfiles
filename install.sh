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

  # TODO: Check for dangling symlinks for directory linking?
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

# FIXME: It seems things fail if we try and copy a .config/$DIR/ that does not exist
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

generate() {
  TARGET="$(realpath "$1")"
  shift
  if type -p "$1" >/dev/null; then
    printf "$ %-40s → ~/%s\n" "$*" "$(realpath --relative-base="${HOME}" "${TARGET}")"
    "$@" >"${TARGET}"
  fi
}

echo Setting up links:
symlink ~/.config/fish/ ./fish/
symlink ~/.config/jj/ ./jj/
symlink ~/.editorconfig ./editorconfig
symlink ~/.gitconfig ./gitconfig
symlink ~/.profile ./profile
symlink ~/.screenrc ./screenrc
symlink ~/.ssh/ ./ssh/
symlink ~/.tmux.conf ./tmux
symlink ~/.vim/ ./vim/
symlink ~/.vimrc ./vimrc
symlink ~/.zshrc ./zshrc

echo
echo Generating completions:
generate ~/.config/fish/completions/av.fish av completion fish
generate ~/.config/fish/completions/gh.fish gh completion -s fish
generate ~/.config/fish/completions/jj.fish jj util completion fish
generate ~/.config/fish/completions/poetry.fish poetry completions fish

echo
echo Linking local bin:
symlink ~/.local/bin/ ./bin/

echo
echo Remember to run:
echo
echo $ apt install ack-grep bind9-host dnsutils git ipython3 less mosh screen vim zsh
echo $ apt install fish tmux neovim ripgrep
echo $ dpkg-reconfigure locales
echo

# TODO: mise

# FIXME: It seems this check breaks inside my tmux
if test -z "${SSH_TTY:-}"; then
  echo Setting up desktop links:
  symlink ~/.config/foot/ ./foot/
  symlink ~/.config/ghostty/ ./ghostty/
  symlink ~/.config/i3/ ./i3/
  symlink ~/.config/i3status/ ./i3status/
  symlink ~/.config/kanshi/ ./kanshi/
  symlink ~/.config/kitty/ ./kitty/
  symlink ~/.config/sway/ ./sway/
  symlink ~/.config/swaync/ ./swaync/
  symlink ~/.config/way-displays/ ./way-displays/
  symlink ~/.config/waybar/ ./waybar/
  symlink ~/.Xresources ./xresources

  # Only setup gpg on local desktops
  symlink ~/.gnupg/ ./gnupg/

  # TODO: Is inputplug needed with sway?
  # TODO: Clean out unused tools?
  # TODO: Consider tpm/yubikey specific agents?

  echo
  echo Remember to run:
  echo
  echo $ apt install i3 kitty redshift xss-lock xautolock pavucontrol kitty inputplug
  echo $ apt install sway waybar foot swayidle fonts-firacode light kanshi ddcutil
  echo $ apt install ghostty way-displays gammastep
  echo $ apt install scdaemon gnupg gnupg-agent libccid pinentry-curses dbus-user-session
  echo
  echo $ gsettings set org.gnome.settings-daemon.plugins.keyboard active false
  echo
  printf "$ gpg2 --edit-card\nfetch\n^D\n"
  printf "$ gpg2 --edit-key 9714F97B0CBEE929\ntrust\n^D\n"
  echo
fi

echo "Making sure .ssh and .gnupg are private."
${RUN} chmod 700 ~/.ssh
${RUN} chmod 700 ~/.gnupg
