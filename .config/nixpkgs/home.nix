{ config, pkgs, ... }:

{
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "oliver";
    home.homeDirectory = "/home/oliver";

    home.packages = with pkgs; [
        # languages
        mitscheme
        clojure
        elixir
        fennel
        ocaml
        rustc
        zig
        ghc
        go

        # language servers
        sumneko-lua-language-server
        haskell-language-server
        rust-analyzer
        clojure-lsp
        pyright
        gopls
        zls

        # formatters
        stylish-haskell
        ocamlformat
        rustfmt
        joker
        yapf

        # others
        translate-shell
        android-tools
        leiningen
        neofetch
        sccache
        ripgrep
        strace
        bottom
        pandoc
        podman
        rlwrap
        yt-dlp
        cargo
        aria2
        stack
        mold
        mypy
        opam
        mutt
        stow
        cmus
        tmux
        fzf
        jq
        lf
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
