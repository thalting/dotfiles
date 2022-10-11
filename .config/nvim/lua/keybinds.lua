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
    { "n", "<M-q>", ":wincmd c<cr>" },
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

    -- knap
    -- F5 processes the document once, and refreshes the view
    { "i", "<F5>", ":lua require('knap').process_once()<cr>" },
    { "v", "<F5>", ":lua require('knap').process_once()<cr>" },
    { "n", "<F5>", ":lua require('knap').process_once()<cr>" },

    -- closes the viewer application,'and 'llows settings to be reset
    { "i", "<F6>", ":lua require('knap').close_viewer()<cr>" },
    { "v", "<F6>", ":lua require('knap').close_viewer()<cr>" },
    { "n", "<F6>", ":lua require('knap').close_viewer()<cr>" },

    -- toggles the auto-processing on'and 'ff
    { "i", "<F7>", ":lua require('knap').toggle_autopreviewing()<cr>" },
    { "v", "<F7>", ":lua require('knap').toggle_autopreviewing()<cr>" },
    { "n", "<F7>", ":lua require('knap').toggle_autopreviewing()<cr>" },

    -- invokes a SyncTeX forward sear'h, o' similar, where appropriate
    { "i", "<F8>", ":lua require('knap').forward_jump()<cr>" },
    { "v", "<F8>", ":lua require('knap').forward_jump()<cr>" },
    { "n", "<F8>", ":lua require('knap').forward_jump()<cr>" },

    -- telescope
    { "n", "<leader>tf", ":lua require('telescope.builtin').find_files()<cr>" },
    { "n", "<leader>tg", ":lua require('telescope.builtin').live_grep()<cr>" },
    { "n", "<leader>tb", ":lua require('telescope.builtin').buffers()<cr>" },
    { "n", "<leader>th", ":lua require('telescope.builtin').help_tags()<cr>" },

    -- hop
    { "n", "<leader>w", ":HopWord<cr>" },
    { "n", "f", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true })<cr>" },
    { "n", "F", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>" },
    { "n", "t", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>" },
    { "n", "T", ":lua require('hop').hint_char1({ direction = require('hop.hint').HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>" },

    -- toggleterm
    { "t", "<C-z>", "<C-\\><C-N>" },
    { "n", "<C-t>", ":ToggleTerm size=20 direction=horizontal<cr>" },
    { "t", "<C-t>", "<C-\\><C-N> :ToggleTerm size=20 direction=horizontal<cr>" }, -- fix toggle in zsh vi mode

    { "n", "<S-t>", ":ToggleTerm direction=float<cr>" },
    { "t", "<S-t>", "<C-\\><C-N> :ToggleTerm direction=float<cr>" }, -- fix toggle in zsh vi mode

    -- lf
    { "n", "<C-l>", ":lua require('lf').start()<cr>", },

    -- lsp
    { "n", "gD", ":lua vim.lsp.buf.declaration()<cr>" },
    { "n", "gd", ":lua vim.lsp.buf.definition()<cr>" },
    { "n", "<leader>h", ":lua vim.lsp.buf.hover()<cr>" },
    { "n", "gi", ":lua vim.lsp.buf.implementation()<cr>" },
    { "n", "<C-k>", ":lua vim.lsp.buf.signature_help()<cr>" },
    { "n", "<space>wa", ":lua vim.lsp.buf.add_workspace_folder()<cr>" },
    { "n", "<space>wr", ":lua vim.lsp.buf.remove_workspace_folder()<cr>" },
    { "n", "<space>wl", ":lua function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end<cr>" },
    { "n", "<space>D", ":lua vim.lsp.buf.type_definition()<cr>" },
    { "n", "<space>rn", ":lua vim.lsp.buf.rename()<cr>" },
    { "n", "<space>ca", ":lua vim.lsp.buf.code_action()<cr>" },
    { "n", "gr", ":lua vim.lsp.buf.references()<cr>" },
    { "n", "<space>f", ":lua vim.lsp.buf.format()<cr>" },

    -- neogit
    { "n", "<space>g", ":Neogit<cr>" },

    -- gitsigns
    { 'n', '<space>gsa', ':Gitsigns attach<cr>' },
    { 'n', '<space>gsd', ':Gitsigns detach<cr>' },
    { 'n', '<space>gsb', ':Gitsigns blame_line<cr>' },
    { 'n', '<space>gst', ':Gitsigns toggle_current_line_blame<cr>' },

    -- hover
    { "n", "<space>h", ":lua require('hover').hover()<cr>" },

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
