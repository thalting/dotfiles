set -U fish_greeting

if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin jorgebucaran/autopair.fish
fundle plugin nickeb96/puffer-fish
fundle plugin franciscolourenco/done

fundle init

if status is-interactive
    clear # fix urxvt

    fish_config theme choose Base16\ Default\ Dark
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block
end

function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert \cf accept-autosuggestion
end

if status is-login
    set -x GOPATH "$HOME/.go"

    set -x PYTHONSTARTUP "$HOME/.pythonrc"

    set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x XDG_USER_LOCAL "$HOME/.local"
    set -x XDG_DATA_HOME "$HOME/.local/share"

    set -x EDITOR "nvim"
    set -x VISUAL "nvim"
    set -x MANPAGER "nvim +Man!"

    fish_add_path "$HOME/.local/bin" "$HOME/.local/bin/blocks" "$GOPATH/bin"

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sx 2>/dev/null
    end
end

function fish_mode_prompt
end

function fish_prompt
    printf '%s λ ' (prompt_pwd)
end

abbr cdl 'cd ~/.local'
abbr cdc 'cd ~/.config'
abbr cdca 'cd ~/.cache'

alias g 'git'
alias sx 'sx 2>/dev/null'
alias gdb 'gdb -q'
alias wttr 'curl "wttr.in/?Q"'
alias vi 'nvim'
alias cl 'clear'
alias cp 'cp -iv'
alias l 'ls --group-directories-first --color=auto'
alias ls 'ls --group-directories-first --color=auto'
alias la 'ls -A --group-directories-first --color=auto'
alias ll 'ls -lh --group-directories-first --color=auto'
alias lla 'ls -lAh --group-directories-first --color=auto'
alias lf 'lfcd'
alias mv 'mv -iv'
alias rm 'rm -iv'
alias rmdir 'rmdir -v'
alias mkdir 'mkdir -p'
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'
alias yank 'yank -- xclip -selection clipboard'
alias hexdump 'hexdump -C'
alias diff 'diff --color=auto'
alias df 'df -h'
alias dvi 'doas nvim'
alias orphans 'pacman -Qtdq | doas pacman -Rns -'
alias reboot 'doas reboot'
alias poweroff 'doas poweroff'
alias shutdown 'doas shutdown'
alias xrdb-update 'xrdb $HOME/.Xresources'
alias activate 'source .venv/bin/activate.fish'
alias mouse_l 'xmodmap -e "pointer = 3 2 1"'
alias mouse_r 'xmodmap -e "pointer = 1 2 3"'
alias update-grub 'doas grub-mkconfig -o /boot/grub/grub.cfg'
alias sytdl 'yt-dlp --external-downloader=aria2c --external-downloader-args "--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16"'
