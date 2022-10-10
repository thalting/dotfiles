require("impatient")

require "paq" {
    "savq/paq-nvim",

    -- org
    "nvim-orgmode/orgmode",
    "akinsho/org-bullets.nvim",

    -- lsp and completions
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "saadparwaiz1/cmp_luasnip",
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "lewis6991/hover.nvim",
    "hrsh7th/cmp-cmdline",
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
    "hrsh7th/cmp-buffer",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-path",

    -- visual
    { "nvim-treesitter/nvim-treesitter", run = function()
        vim.cmd("TSUpdate")
    end },
    "kyazdani42/nvim-web-devicons",
    'NvChad/nvim-colorizer.lua',
    "nvim-lualine/lualine.nvim",
    "RRethy/nvim-base16",

    -- git
    "lewis6991/gitsigns.nvim",
    "TimUntersberger/neogit",

    -- life quality
    "nvim-telescope/telescope.nvim",
    "akinsho/toggleterm.nvim",
    "kylechui/nvim-surround",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "phaazon/hop.nvim",
    "lmburns/lf.nvim",

    -- other
    "lewis6991/impatient.nvim",
    "nvim-lua/plenary.nvim",
    "Olical/conjure",
    "frabjous/knap",
}

require("orgmode").setup()
require("orgmode").setup_ts_grammar()
require("org-bullets").setup()
require("gitsigns").setup({
    current_line_blame_opts = {
        delay = 10,
    },
})
require("neogit").setup()
require("toggleterm").setup()
require("Comment").setup()
require("nvim-surround").setup()

require("colorizer").setup({
    user_default_options = {
        names = false,
    },
})

require("hop").setup({
    keys = "asdfghjkl",
})

require("hover").setup {
    init = function()
        require("hover.providers.lsp")
    end,
    preview_opts = {
        border = nil
    },
    preview_window = false,
    title = false
}

require("nvim-autopairs").setup({
    disale_in_macro = true,
    enable_check_bracket_line = false,
})

require("null-ls").setup({
    sources = {
        -- formatters
        require("null-ls").builtins.formatting.yapf,

        -- code actions
        require("null-ls").builtins.code_actions.gitsigns,

        -- diagnostics
        require("null-ls").builtins.diagnostics.zsh,
        require("null-ls").builtins.diagnostics.mypy,
        require("null-ls").builtins.diagnostics.shellcheck,

        -- hover
        require("null-ls").builtins.hover.dictionary,
    },
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
    },
    indent = {
        enable = true,
        disable = { "python" },
    },
})
