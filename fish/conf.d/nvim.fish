# Only alias if configured
if test -d ~/.config/nvim/
  alias vim=nvim
  set --export EDITOR nvim
end
