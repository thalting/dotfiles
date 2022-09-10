require("paq")({
    "savq/paq-nvim",

    -- org
    "nvim-orgmode/orgmode",
    "akinsho/org-bullets.nvim",

    -- lsp and completions
    "williamboman/nvim-lsp-installer",
    "jose-elias-alvarez/null-ls.nvim",
    "saadparwaiz1/cmp_luasnip",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",

    -- visual
    "nvim-treesitter/nvim-treesitter",
    "kyazdani42/nvim-web-devicons",
    "norcalli/nvim-colorizer.lua",
    "nvim-lualine/lualine.nvim",
    "RRethy/nvim-base16",

    -- git
    "lewis6991/gitsigns.nvim",
    "TimUntersberger/neogit",
    "sindrets/diffview.nvim",

    -- life quality
    "nvim-telescope/telescope.nvim",
    "akinsho/toggleterm.nvim",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "ur4ltz/surround.nvim",
    "phaazon/hop.nvim",
    "lmburns/lf.nvim",

    -- other
    "nvim-lua/plenary.nvim",
    "Olical/conjure",
})

require("hop").setup({
    keys = "etovxqpdygfblzhckisuran",
})

require("surround").setup({
    mappings_style = "surround",
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

require("nvim-web-devicons").setup({
    override = {
        zig = {
            icon = "",
        },
        nim = {
            icon = "",
        },
    },
})

require("null-ls").setup({
    sources = {
        -- formatters
        require("null-ls").builtins.formatting.yapf,
        require("null-ls").builtins.formatting.joker,

        -- diagnostics
        require("null-ls").builtins.diagnostics.mypy,
    },
})

require("org-bullets").setup({
    concealcursor = false,
    symbols = {
        headlines = { "◉", "○", "✸", "✿" },
        checkboxes = {
            half = { "", "OrgTSCheckboxHalfChecked" },
            done = { "✓", "OrgDone" },
            todo = { "˟", "OrgTODO" },
        },
    },
})

require("nvim-autopairs").setup({
    disale_in_macro = true,
    enable_check_bracket_line = false,
})

require("toggleterm").setup()

require("telescope").setup()

require("colorizer").setup()

require("Comment").setup()

require("orgmode").setup_ts_grammar()

require("orgmode").setup()
