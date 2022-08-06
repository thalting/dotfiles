vim.g.mapleader = ","
vim.g.maplocalleader = ","

local mappings = {
    -- my maps
    { "n", "ZW", ":w<cr>" },
    { "n", "<leader>s", ":%s/" },

    -- windows
    { "n", "<M-h>", ":wincmd h<cr>" },
    { "n", "<M-j>", ":wincmd j<cr>" },
    { "n", "<M-k>", ":wincmd k<cr>" },
    { "n", "<M-l>", ":wincmd l<cr>" },
    { "n", "<M-c>", ":wincmd c<cr>" },
    { "n", "<M-n>", ":wincmd n<cr>" },
    { "n", "<M-,>", ":wincmd <<cr>" },
    { "n", "<M-.>", ":wincmd ><cr>" },
    { "n", "<M-=>", ":wincmd +<cr>" },
    { "n", "<M-->", ":wincmd -<cr>" },
    { "n", "<M-H>", ":wincmd H<cr>" },
    { "n", "<M-J>", ":wincmd J<cr>" },
    { "n", "<M-K>", ":wincmd K<cr>" },
    { "n", "<M-L>", ":wincmd L<cr>" },
    { "n", "<M-r>", ":wincmd r<cr>" },
    { "n", "<M-R>", ":wincmd R<cr>" },
    { "n", "<M-T>", ":wincmd T<cr>" },
    { "n", "<M-v>", ":vnew<cr>" },

    -- telescope
    { "n", "<leader>tf", ":lua require('telescope.builtin').find_files()<cr>" },
    { "n", "<leader>tg", ":lua require('telescope.builtin').live_grep()<cr>" },
    { "n", "<leader>tb", ":lua require('telescope.builtin').buffers()<cr>" },
    { "n", "<leader>th", ":lua require('telescope.builtin').help_tags()<cr>" },

    -- barbar
    { 'n', '<A-,>', '<Cmd>BufferPrevious<CR>' },
    { 'n', '<A-.>', '<Cmd>BufferNext<CR>' },
    { 'n', '<A-<>', '<Cmd>BufferMovePrevious<CR>' },
    { 'n', '<A->>', '<Cmd>BufferMoveNext<CR>',  },
    { 'n', '<A-1>', '<Cmd>BufferGoto 1<CR>' },
    { 'n', '<A-2>', '<Cmd>BufferGoto 2<CR>' },
    { 'n', '<A-3>', '<Cmd>BufferGoto 3<CR>' },
    { 'n', '<A-4>', '<Cmd>BufferGoto 4<CR>' },
    { 'n', '<A-5>', '<Cmd>BufferGoto 5<CR>' },
    { 'n', '<A-6>', '<Cmd>BufferGoto 6<CR>' },
    { 'n', '<A-7>', '<Cmd>BufferGoto 7<CR>' },
    { 'n', '<A-8>', '<Cmd>BufferGoto 8<CR>' },
    { 'n', '<A-9>', '<Cmd>BufferGoto 9<CR>' },
    { 'n', '<A-0>', '<Cmd>BufferLast<CR>'  },
    { 'n', '<A-p>', '<Cmd>BufferPin<CR>' },
    { 'n', '<A-c>', '<Cmd>BufferClose<CR>'  },
    { 'n', '<C-p>', '<Cmd>BufferPick<CR>' },
    { 'n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>' },
    { 'n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>' },
    { 'n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>' },
    { 'n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>' },

    -- hop
    { "n", "f", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>" },
    { "n", "F", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>" },
    { "n", "t", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>" },
    { "n", "T", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>" },

    -- toggleterm
    { "n", "<C-t>", ":ToggleTerm<cr>" },
    { "n", "<S-t>", ":ToggleTerm direction=float<cr>" },

    -- lf
    { "n", "<C-l>", ":lua require('lf').start()<cr>", },

    -- formatter
    { "n", "<leader>f", ":Format<CR>" },

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
