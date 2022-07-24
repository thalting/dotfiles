vim.g.mapleader = ","
vim.g.maplocalleader = ","

local mappings = {
    -- my maps
    { "", "ZW", ":w<cr>" },
    { "", "<leader>s", ":%s/" },

    -- telescope
    { "n", "<leader>tf", ":lua require('telescope.builtin').find_files()<cr>" },
    { "n", "<leader>tg", ":lua require('telescope.builtin').live_grep()<cr>" },
    { "n", "<leader>tb", ":lua require('telescope.builtin').buffers()<cr>" },
    { "n", "<leader>th", ":lua require('telescope.builtin').help_tags()<cr>" },

    -- hop
    { "n", "f", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>" },
    { "n", "F", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>" },
    { "n", "t", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>" },
    { "n", "T", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>" },

    -- toggleterm
    { "n", "<C-t>", ":ToggleTerm direction=float<cr>" },

    -- lf
    { "n", "<C-l>", ":lua require('lf').start()<cr>", },

    -- formatter
    { "", "<C-f>", ":Format<CR>" },

    -- lsp
    { "n", "gD", ":lua vim.lsp.buf.declaration()<cr>" },
    { "n", "gd", ":lua vim.lsp.buf.definition()<cr>" },
    { "n", "K", ":lua vim.lsp.buf.hover()<cr>" },
    { "n", "gi", ":lua vim.lsp.buf.implementation()<cr>" },
    { "n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>" },
    { "n", "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<cr>" },
    { "n", "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<cr>" },
    { "n", "<space>wl", ":lua function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end<cr>" },
    { "n", "<space>D", ":lua vim.lsp.buf.type_definition()<cr>" },
    { "n", "<space>rn", ":lua vim.lsp.buf.rename()<cr>" },
    { "n", "<space>ca", ":lua vim.lsp.buf.code_action()<cr>" },
    { "n", "gr", ":lua vim.lsp.buf.references()<cr>" },
    { "n", "<space>f", ":lua vim.lsp.buf.formatting()<cr>" },

    -- buffers
    { "n", "<leader>bd", ":bdelete<cr>"},
    { "n", "<leader>bn", ":bnext<cr>"},
    { "n", "<leader>bp", ":bprevious<cr>"},
}

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

for _, maps in pairs(mappings) do
    map(unpack(maps))
end
