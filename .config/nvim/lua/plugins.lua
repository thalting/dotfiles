require("paq")({
    "savq/paq-nvim",

    "sheerun/vim-polyglot",

    "nvim-lua/plenary.nvim",

    "williamboman/nvim-lsp-installer",

    "nvim-telescope/telescope.nvim",

    "lewis6991/gitsigns.nvim",

    "neovim/nvim-lspconfig",

    "hrsh7th/nvim-cmp",

    "hrsh7th/cmp-nvim-lsp",

    "saadparwaiz1/cmp_luasnip",

    "L3MON4D3/LuaSnip",

    "rafamadriz/friendly-snippets",

    "nvim-treesitter/nvim-treesitter",

    "ur4ltz/surround.nvim",

    "numToStr/Comment.nvim",

    "norcalli/nvim-colorizer.lua",

    "windwp/nvim-autopairs",

    "kyazdani42/nvim-web-devicons",

    "nvim-lualine/lualine.nvim",

    "mhartington/formatter.nvim",

    "RRethy/nvim-base16",
})

require("surround").setup({
    mappings_style = "surround",
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
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

require("formatter").setup({
    filetype = {
        c = {
            require("formatter.filetypes.cpp").clangformat,
        },
        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        rust = {
            require("formatter.filetypes.rust").rustfmt,
        },
        python = {
            require("formatter.filetypes.python").yapf,
        },
    },
})

require("gitsigns").setup()

require("telescope").setup()

require("Comment").setup()

require("colorizer").setup()

require("nvim-autopairs").setup()
