local pkgs = {
    "savq/paq-nvim",

    -- org
    "nvim-orgmode/orgmode",
    "akinsho/org-bullets.nvim",

    -- lsp and completions
    "williamboman/mason-lspconfig.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "saadparwaiz1/cmp_luasnip",
    "williamboman/mason.nvim",
    "PaterJason/cmp-conjure",
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "lewis6991/hover.nvim",
    "hrsh7th/cmp-cmdline",
    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",
    "hrsh7th/cmp-buffer",
    "j-hui/fidget.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-path",

    -- visual
    {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            vim.cmd("TSUpdate")
        end,
    },
    "kyazdani42/nvim-web-devicons",
    "NvChad/nvim-colorizer.lua",
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
    "folke/which-key.nvim",
    "phaazon/hop.nvim",
    "lmburns/lf.nvim",
    "Olical/conjure",
    "frabjous/knap",

    -- other
    "lewis6991/impatient.nvim",
    "nvim-lua/plenary.nvim",
}

return pkgs
