require("paq")({
    "savq/paq-nvim",

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

    "phaazon/hop.nvim",

    "akinsho/toggleterm.nvim",

    "lmburns/lf.nvim",

    "RRethy/nvim-base16",
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

require("formatter").setup({
    filetype = {
        c = {
            require("formatter.filetypes.c").clangformat,
        },
        go = {
            require("formatter.filetypes.go").gofmt,
        },
        cpp = {
            require("formatter.filetypes.cpp").clangformat,
        },
        lua = {
            require("formatter.filetypes.lua").stylua,
        },
        zig = {
            require("formatter.filetypes.zig").zigfmt,
        },
        rust = {
            require("formatter.filetypes.rust").rustfmt,
        },
        ocaml = {
            require("formatter.filetypes.ocaml").ocamlformat,
        },
        python = {
            require("formatter.filetypes.python").yapf,
        },
    },
})

require("lf").setup({
    default_cmd = "lf",
    default_action = "edit",
    default_actions = {
        ["<C-t>"] = "tabedit",
        ["<C-x>"] = "split",
        ["<C-v>"] = "vsplit",
        ["<C-o>"] = "tab drop",
    },
    winblend = 10,
    dir = "",
    direction = "float",
    border = "double",
    height = 0.80,
    width = 0.85,
    escape_quit = true,
    focus_on_open = false,
    mappings = true,
    tmux = false,
    layout_mapping = "<A-u>",
    views = {
        { width = 0.600, height = 0.600 },
        { width = 0.800, height = 0.800 },
        { width = 0.950, height = 0.950 },
    },
})

require("toggleterm").setup()

require("gitsigns").setup()

require("telescope").setup()

require("Comment").setup()

require("colorizer").setup()

require("nvim-autopairs").setup()
