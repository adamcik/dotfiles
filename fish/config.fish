set --export EDITOR vim
set --export LANG en_DK.utf8
set --export PATH ~/.local/bin $PATH
set --export MOSH_SERVER_NETWORK_TMOUT 2592000
set --export PYTHON_KEYRING_BACKEND keyring.backends.null.Keyring

set fish_greeting

set fish_color_normal normal
set fish_color_command --bold
set fish_color_param cyan
set fish_color_redirection brblue
set fish_color_comment red
set fish_color_error brred
set fish_color_escape bryellow --bold
set fish_color_operator bryellow
set fish_color_end brmagenta
set fish_color_quote yellow
set fish_color_autosuggestion 555 brblack
set fish_color_user brgreen
set fish_color_host blue
set fish_color_host_remote cyan

set color_cwd yellow

eval (direnv hook fish)
