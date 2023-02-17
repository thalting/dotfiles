set -U fish_greeting

if status is-interactive
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual block

    fish_vi_key_bindings
end

if status is-login
    set -x GOPATH "$HOME/.go"

    set -x HYSTARTUP "$HOME/.config/hy/init.hy"
    set -x PYTHONSTARTUP "$HOME/.config/python/init.py"

    set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x XDG_USER_LOCAL "$HOME/.local"
    set -x XDG_DATA_HOME "$HOME/.local/share"

    set -x EDITOR "nvim"
    set -x MANPAGER "nvim +Man!"

    set -gx PATH $PATH "$HOME/.local/bin" "$HOME/.local/bin/blocks" "$GOPATH/bin"

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sx 2>/dev/null
    end
end

function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold yellow
      echo '[N] '
    case insert
      set_color --bold magenta
      echo '[I] '
    case replace_one
      set_color --bold green
      echo '[R] '
    case visual
      set_color --bold blue
      echo '[V] '
    case '*'
      set_color --bold red
      echo '[?] '
  end
  set_color normal
end

function fish_prompt
    printf '%s%s%s λ ' (set_color normal) (prompt_pwd) (set_color normal)
end

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
