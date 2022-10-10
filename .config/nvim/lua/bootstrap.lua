local PKGS = {
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

local function clone_paq()
    local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.system {
            'git',
            'clone',
            '--depth=1',
            'https://github.com/savq/paq-nvim.git',
            path
        }
    end
end

local function bootstrap_paq()
    clone_paq()

    -- Load Paq
    vim.cmd('packadd paq-nvim')
    local paq = require('paq')

    -- Exit nvim after installing plugins
    vim.cmd('autocmd User PaqDoneInstall quit')

    -- Read and install packages
    paq(PKGS)
    paq.install()
end

return { bootstrap_paq = bootstrap_paq }
