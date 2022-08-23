# PATH
PATH="$HOME/.local/bin:$PATH"

# others
source /etc/profile.d/nix-daemon.sh
eval $(opam env)

# XDG vars
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_USER_LOCAL="$HOME/.local"
export XDG_DATA_HOME="$HOME/.local/share"

export PAGER=less
export EDITOR=nvim

[ "$(tty)" = "/dev/tty1" ] && sx 2>/dev/null
