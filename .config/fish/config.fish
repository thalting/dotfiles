set -U fish_greeting

if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin jorgebucaran/autopair.fish
fundle plugin nickeb96/puffer-fish
fundle plugin franciscolourenco/done

fundle init

if status is-interactive
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
    set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

    set -x XDG_CONFIG_HOME "$HOME/.config"
    set -x XDG_CACHE_HOME "$HOME/.cache"
    set -x XDG_USER_LOCAL "$HOME/.local"
    set -x XDG_DATA_HOME "$HOME/.local/share"

    set -x GOPATH "$XDG_DATA_HOME/go"
    set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/.pythonrc"
    set -x ANDROID_USER_HOME "$XDG_DATA_HOME/android"
    set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
    set -x CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
    set -x GNUPGHOME "$XDG_DATA_HOME/gnupg"
    set -x GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
    set -x XCURSOR_PATH "/usr/share/icons:$XDG_DATA_HOME/icons"
    set -x PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"

    # set -x EDITOR "nvim"
    # set -x VISUAL "nvim"
    # set -x MANPAGER "nvim +Man!"

    fish_add_path "$HOME/.local/bin" "$HOME/.local/bin/blocks" "$GOPATH/bin"

    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec sx 2>/dev/null
    end
end

function fish_mode_prompt
end

function fish_prompt
  set -l last_status $status

  if not set -q __fish_git_prompt_show_informative_status
    set -g __fish_git_prompt_show_informative_status 1
  end
  if not set -q __fish_git_prompt_color_branch
    set -g __fish_git_prompt_color_branch brmagenta
  end
  if not set -q __fish_git_prompt_showupstream
    set -g __fish_git_prompt_showupstream "informative"
  end
  if not set -q __fish_git_prompt_showdirtystate
    set -g __fish_git_prompt_showdirtystate "yes"
  end
  if not set -q __fish_git_prompt_color_stagedstate
    set -g __fish_git_prompt_color_stagedstate yellow
  end
  if not set -q __fish_git_prompt_color_invalidstate
    set -g __fish_git_prompt_color_invalidstate red
  end
  if not set -q __fish_git_prompt_color_cleanstate
    set -g __fish_git_prompt_color_cleanstate brgreen
  end

  printf '%s%s%s ' (prompt_pwd) (set_color normal) (__fish_git_prompt)

  if not test $last_status -eq 0
    set_color $fish_color_error
  end
  echo -n 'λ '
  set_color normal
end

abbr suspend --set-cursor=! 'sudo bash -c "{ sleep !m && systemctl suspend; } &"'

alias cdl 'cd ~/.local'
alias cdc 'cd ~/.config'
alias cdca 'cd ~/.cache'
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
alias stowl 'stow . -t ~'
alias orphans 'pacman -Qtdq | sudo pacman -Rns -'
alias reboot 'sudo reboot'
alias poweroff 'sudo poweroff'
alias shutdown 'sudo shutdown'
alias xrdb-update 'xrdb $HOME/.Xresources'
alias activate 'source .venv/bin/activate.fish'
alias mouse_l 'xmodmap -e "pointer = 3 2 1 5 4 7 6 8 9 10"'
alias mouse_r 'xmodmap -e "pointer = 1 2 3 4 5 7 6 8 9 10"'
alias update-grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias sytdl 'yt-dlp --external-downloader=aria2c --external-downloader-args "--min-split-size=1M --max-connection-per-server=16 --max-concurrent-downloads=16 --split=16"'
