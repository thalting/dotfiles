require("paq")({
    "savq/paq-nvim",

    "nvim-lua/plenary.nvim",

    "williamboman/nvim-lsp-installer",

    "nvim-telescope/telescope.nvim",

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

local colors = {
    black = "#0c0c0d",
    white = "#d8d8d8",
    purple = "#ba8baf",
    yellow = "#f7ca88",
}

local dumb = {
    normal = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.white, bg = colors.black },
    },

    insert = { a = { fg = colors.yellow, bg = colors.black } },
    visual = { a = { fg = colors.purple, bg = colors.black } },
    replace = { a = { fg = colors.black, bg = colors.black } },

    inactive = {
        a = { fg = colors.white, bg = colors.black },
        b = { fg = colors.white, bg = colors.black },
        c = { fg = colors.black, bg = colors.black },
    },
}

require("lualine").setup({
    options = {
        section_separators = { "", "" },
        component_separators = { "|", "|" },
        theme = dumb,
    },
    sections = {
        lualine_b = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic", "nvim_lsp" },
                sections = { "error", "warn", "info", "hint" },
                diagnostics_color = {
                    error = "DiagnosticError",
                    warn = "DiagnosticWarn",
                    info = "DiagnosticInfo",
                    hint = "DiagnosticHint",
                },
                symbols = { error = "E", warn = "W", info = "I", hint = "H" },
                colored = true,
                update_in_insert = false,
                always_visible = false,
            },
        },
    },
})

require("surround").setup({
    mappings_style = "surround",
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
})

require("formatter").setup({
    filetype = {
        cpp = {
            -- clang-format
            function()
                return {
                    exe = "clang-format",
                    args = {
                        "--assume-filename",
                        vim.api.nvim_buf_get_name(0),
                    },
                    stdin = true,
                    cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
                }
            end,
        },
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--config-path "
                            .. os.getenv("XDG_CONFIG_HOME")
                            .. "/stylua/stylua.toml",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        rust = {
            -- Rustfmt
            function()
                return {
                    exe = "rustfmt",
                    args = { "--emit=stdout", "--edition=2021" },
                    stdin = true,
                }
            end,
        },
    },
})

require("telescope").setup()

require("Comment").setup()

require("colorizer").setup()

require("nvim-autopairs").setup()
