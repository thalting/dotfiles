# Sources
source "$HOME/.local/share/miniplug.zsh"

miniplug plugin 'hlissner/zsh-autopair'
miniplug plugin 'kutsan/zsh-system-clipboard'
miniplug plugin 'zdharma-continuum/fast-syntax-highlighting'

miniplug load

# My PROMPT
PROMPT="[%~] λ "

stty -ixon -ixoff # Disable ctrl-S/ctrl-Q for START/STOP
setopt autocd # Automatically cd into typed directory
setopt interactive_comments

# Vi mode
bindkey -v
bindkey -v '^?' backward-delete-char
export KEYTIMEOUT=1

# Surround
autoload -Uz surround
zle -N delete-surround surround
zle -N add-surround surround
zle -N change-surround surround
bindkey -a cs change-surround
bindkey -a ds delete-surround
bindkey -a ys add-surround
bindkey -M visual S add-surround

# Basic auto/tab complete:
zstyle ':completion:*' menu select
autoload -U compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
zle-keymap-select() {
    case $KEYMAP in
        vicmd)
            printf "\x1b[\x32 q" ;; # Steady block
        viins|main)
            printf "\x1b[\x36 q" ;; # Steady bar
    esac
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate vi insert as keymap (can be removed if bindkey -V has been set elsewhere)
    printf "\x1b[\x36 q" # Steady bar
}
zle -N zle-line-init

printf "\x1b[\x36 q" # Steady bar

preexec() {
    printf "\x1b[\x36 q" # Steady bar
}

lfcd() {
    local tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# Dynamic window title with zsh shell.
# Shows current directory and running (multi-line) command.
case "$TERM" in (rxvt|rxvt-*|st|st-*|*xterm*|(dt|k|E)term)
    local term_title() {
        print -n "\e]0;${(j: :q)@}\a"
    }
    precmd() {
      term_title "st"
    }
    preexec() {
      local CMD="${(j:\n:)${(f)1}}"
      term_title "$CMD"
    }
    ;;
esac
