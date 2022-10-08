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
}

vim.opt.fillchars = { eob = " " }

for k, v in pairs(opts) do
    vim.o[k] = v
end

local gknapsettings = {
    textopdfviewerlaunch = [[zathura --synctex-editor-command
                            'nvim --headless -es --cmd \
                            "lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"'
                            %outputfile%]],
    textopdfviewerrefresh = "none",
    textopdfforwardjump = "zathura --synctex-forward=%line%:%column%:%srcfile% %outputfile%",

    mdtohtmlviewerlaunch = "luakit %outputfile%",
    mdtohtmlviewerrefresh = "none",
}
vim.g.knap_settings = gknapsettings

vim.g["conjure#filetype#scheme"] = "conjure.client.guile.socket"
vim.g["conjure#client#guile#socket#pipename"] = ".guile-repl.socket"
