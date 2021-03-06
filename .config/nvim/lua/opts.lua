local opts = {
    -- tabs
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    -- numbers
    number = true,
    relativenumber = true,

    -- misc
    list = true,
    wrap = false,
    confirm = true,
    swapfile = false,
    shortmess = "I",
    cursorline = true,
    inccommand = "split",
    clipboard = "unnamedplus",
    termguicolors = true,
    lazyredraw = true,
    hidden = true,
}

vim.opt.fillchars = { eob = " " }

for k, v in pairs(opts) do
    vim.o[k] = v
end
