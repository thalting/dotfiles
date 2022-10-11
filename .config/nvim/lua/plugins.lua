require("impatient")

local pkgs = require("pkgs")
require("paq")({unpack(pkgs)})

require("orgmode").setup()
require("orgmode").setup_ts_grammar()
require("org-bullets").setup()
require("neogit").setup()
require("toggleterm").setup()
require("Comment").setup()
require("nvim-surround").setup()
require("fidget").setup()
require("which-key").setup()

require("gitsigns").setup({
    current_line_blame_opts = {
        delay = 10,
    },
})

require("colorizer").setup({
    user_default_options = {
        names = false,
    },
})

require("hop").setup({
    keys = "asdfghjkl",
})

require("hover").setup({
    init = function()
        require("hover.providers.lsp")
    end,
    preview_opts = {
        border = nil,
    },
    preview_window = false,
    title = false,
})

require("nvim-autopairs").setup({
    disale_in_macro = true,
    enable_check_bracket_line = false,
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "go",
        "vim",
        "cpp",
        "zig",
        "lua",
        "org",
        "nix",
        "rust",
        "llvm",
        "bash",
        "make",
        "ocaml",
        "meson",
        "python",
        "fennel",
        "elixir",
        "sxhkdrc",
        "haskell",
        "markdown",
        "gitignore",
        "javascript",
        "typescript",
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
})
