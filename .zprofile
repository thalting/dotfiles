# others
source /etc/profile.d/nix-daemon.sh
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
export GOPATH="$HOME/.go"

# XDG vars
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_USER_LOCAL="$HOME/.local"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# PATH
PATH="$HOME/.local/bin:$HOME/.local/bin/blocks:$GOPATH/bin:$PATH"

[ "$(tty)" = "/dev/tty1" ] && sx 2>/dev/null
