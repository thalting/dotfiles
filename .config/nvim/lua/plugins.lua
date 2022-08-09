require("paq")({
    "savq/paq-nvim",

    "nvim-lua/plenary.nvim",

    "Olical/conjure",

    "hkupty/iron.nvim",

    "williamboman/nvim-lsp-installer",

    "nvim-telescope/telescope.nvim",

    "lewis6991/gitsigns.nvim",

    "neovim/nvim-lspconfig",

    "hrsh7th/nvim-cmp",

    "hrsh7th/cmp-nvim-lsp",

    "saadparwaiz1/cmp_luasnip",

    "L3MON4D3/LuaSnip",

    "TimUntersberger/neogit",

    "sindrets/diffview.nvim",

    "nvim-treesitter/nvim-treesitter",

    "ur4ltz/surround.nvim",

    "numToStr/Comment.nvim",

    "norcalli/nvim-colorizer.lua",

    "windwp/nvim-autopairs",

    "kyazdani42/nvim-web-devicons",

    "romgrk/barbar.nvim",

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

require("iron.core").setup({
    config = {
        repl_open_cmd = require("iron.view").curry.bottom(20),
    },
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
})

require("nvim-autopairs").setup({
    enable_bracket_in_quote = false,
    enable_check_bracket_line = false,
})

require("lf").setup()

require("toggleterm").setup()

require("gitsigns").setup()

require("telescope").setup()

require("colorizer").setup()

require("Comment").setup()
