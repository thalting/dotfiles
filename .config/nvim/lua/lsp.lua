-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require("lspconfig")

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    "rust_analyzer",
    "sumneko_lua",
    "clojure_lsp",
    "elixirls",
    "ocamllsp",
    "tsserver",
    "pyright",
    "gopls",
    "ccls",
    "hls",
    "zls",
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        -- lsps
        "rust_analyzer",
        "sumneko_lua",
        "clojure_lsp",
        "elixirls",
        "ocamllsp",
        "tsserver",
        "pyright",
        "gopls",
        "zls",

        -- formatters
        "stylua",
        "yapf",

        -- others
        "mypy",
    },
})

require("null-ls").setup({
    sources = {
        -- formatters
        require("null-ls").builtins.formatting.yapf,
        require("null-ls").builtins.formatting.stylua,

        -- code actions
        require("null-ls").builtins.code_actions.gitsigns,
        require("null-ls").builtins.code_actions.shellcheck,

        -- diagnostics
        require("null-ls").builtins.diagnostics.zsh,
        require("null-ls").builtins.diagnostics.mypy,
        require("null-ls").builtins.diagnostics.shellcheck,

        -- hover
        require("null-ls").builtins.hover.dictionary,
    },
})

for _, lsp in ipairs(servers) do
    if lsp == "sumneko_lua" then
        lspconfig.sumneko_lua.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
            capabilities = capabilities,
        })
    else
        lspconfig[lsp].setup({
            capabilities = capabilities,
        })
    end
end

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local snippy = require("snippy")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
    enabled = function()
        -- disable completion in comments
        local context = require("cmp.config.context")
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == "c" then
            return true
        else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        expand = function(args)
            snippy.expand_snippet(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif snippy.can_expand_or_advance() then
                snippy.expand_or_advance()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif snippy.can_jump(-1) then
                snippy.previous()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "orgmode" },
        { name = "conjure" },
        { name = "snippy " },
        { name = "buffer" },
        { name = "path" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
    },
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})
