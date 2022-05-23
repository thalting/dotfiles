local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local mappings = {
    -- my maps
    { "", "ZW", ":w<CR>", { silent = true } },
    { "", "<C-s>", ":%s/" },

    -- telescope
    { "n", "tf", ":lua require('telescope.builtin').find_files()<cr>" },
    { "n", "tg", ":lua require('telescope.builtin').live_grep()<cr>" },
    { "n", "tb", ":lua require('telescope.builtin').buffers()<cr>" },
    { "n", "th", ":lua require('telescope.builtin').help_tags()<cr>" },

    -- formatter
    { "", "<C-f>", ":Format<CR>" },
}

for _, maps in pairs(mappings) do
    map(unpack(maps))
end