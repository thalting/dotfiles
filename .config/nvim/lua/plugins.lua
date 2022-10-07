vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    -- org
    use {
        "nvim-orgmode/orgmode", config = function()
            require("orgmode").setup()
            require("orgmode").setup_ts_grammar()
        end
    }
    use {
        "akinsho/org-bullets.nvim", config = function()
            require("org-bullets").setup()
        end
    }

    -- lsp and completions
    use {
        { "williamboman/nvim-lsp-installer", config = function()
            require("nvim-lsp-installer").setup({
                ui = {
                    icons = {
                        server_installed = "✓",
                        server_pending = "➜",
                        server_uninstalled = "✗",
                    },
                },
            })
        end },
        { "jose-elias-alvarez/null-ls.nvim", config = function()
            require("null-ls").setup({
                sources = {
                    -- formatters
                    require("null-ls").builtins.formatting.yapf,
                    require("null-ls").builtins.formatting.joker,
                },
            })
        end },

        -- cmp
        { "hrsh7th/nvim-cmp",
            requires = {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            }
        },

        "neovim/nvim-lspconfig",

        { "L3MON4D3/LuaSnip", config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end },
        "rafamadriz/friendly-snippets",
    }

    -- visual
    use {
        { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = function()
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
        end },
        "kyazdani42/nvim-web-devicons",
        { "norcalli/nvim-colorizer.lua", config = function()
            require("colorizer").setup()
        end },
        { "nvim-lualine/lualine.nvim", config = require [[statusline]] },
        "RRethy/nvim-base16",
    }

    -- git
    use {
        { "lewis6991/gitsigns.nvim", config = function()
            require("gitsigns").setup()
        end },
        { "TimUntersberger/neogit", config = function()
            require("neogit").setup()
        end },
    }

    -- life quality
    use {
        "nvim-telescope/telescope.nvim",
        { "akinsho/toggleterm.nvim", config = function()
            require("toggleterm").setup()
        end },
        { "numToStr/Comment.nvim", config = function()
            require("Comment").setup()
        end },

        { "windwp/nvim-autopairs", config = function()
            require("nvim-autopairs").setup({
                disale_in_macro = true,
                enable_check_bracket_line = false,
            })
        end },

        { "ur4ltz/surround.nvim", config = function()
            require("surround").setup({
                mappings_style = "surround",
            })
        end },
        { "phaazon/hop.nvim", config = function()
            require("hop").setup({
                keys = "etovxqpdygfblzhckisuran",
            })
        end },
        "lmburns/lf.nvim",
    }

    -- other
    use {
        "nvim-lua/plenary.nvim",
        "Olical/conjure",
    }

    -- bootstrap
    if packer_bootstrap then
        require("packer").sync()
    end
end)
