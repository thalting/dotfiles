------------------------------------------------------------------------------
-- luakit configuration file, more information at https://luakit.github.io/ --
------------------------------------------------------------------------------

require("lfs")

-- Check for lua configuration files that will never be loaded because they are
-- shadowed by builtin modules.
table.insert(package.loaders, 2, function(modname)
    if not package.searchpath then
        return
    end
    local f = package.searchpath(modname, package.path)
    if
        not f
        or f:find(luakit.install_paths.install_dir .. "/", 0, true) ~= 1
    then
        return
    end
    local lf = luakit.config_dir .. "/" .. modname:gsub("%.", "/") .. ".lua"
    if f == lf then
        msg.warn("Loading local version of '" .. modname .. "' module: " .. lf)
    elseif lfs.attributes(lf) then
        msg.warn(
            "Found local version "
                .. lf
                .. " for core module '"
                .. modname
                .. "', but it won't be used, unless you update 'package.path' accordingly."
        )
    end
end)

-- Set the number of web processes to use. A value of 0 means 'no limit'. This
-- has no effect since WebKit 2.26
luakit.process_limit = 4
-- Set the cookie storage location
soup.cookies_storage = luakit.data_dir .. "/cookies.db"

-- Load library of useful functions for luakit
local lousy = require("lousy")

-- Load users theme
-- ("$XDG_CONFIG_HOME/luakit/theme.lua" or "/etc/xdg/luakit/theme.lua")
lousy.theme.init(lousy.util.find_config("theme.lua"))
assert(lousy.theme.get(), "failed to load theme")

-- Load users window class
-- ("$XDG_CONFIG_HOME/luakit/window.lua" or "/etc/xdg/luakit/window.lua")
local window = require("window")

-- Load users webview class
-- ("$XDG_CONFIG_HOME/luakit/webview.lua" or "/etc/xdg/luakit/webview.lua")
local webview = require("webview")

-- Add luakit;//log/ chrome page
local log_chrome = require("log_chrome")

-- Load luakit binds and modes
local modes = require("modes")
local binds = require("binds")

local settings = require("settings")
require("settings_chrome")

----------------------------------
-- Optional user script loading --
----------------------------------

-- Add adblock
local adblock = require("adblock")
local adblock_chrome = require("adblock_chrome")

-- Add uzbl-like form filling
local formfiller = require("formfiller")

-- Add proxy support & manager
local proxy = require("proxy")

-- Add cache control (clear-data, clear-favicon-db)
local clear_data = require("clear_data")

-- Add quickmarks support & manager
local quickmarks = require("quickmarks")

-- Add session saving/loading support
local session = require("session")

-- Add command to list closed tabs & bind to open closed tabs
local undoclose = require("undoclose")

-- Add command to list tab history items
local tabhistory = require("tabhistory")

-- Add command to list open tabs
local tabmenu = require("tabmenu")

-- Add gopher protocol support (this module needs luasocket)
-- local gopher = require "gopher"

-- Add greasemonkey-like javascript userscript support
local userscripts = require("userscripts")

-- Add bookmarks support
local bookmarks = require("bookmarks")
local bookmarks_chrome = require("bookmarks_chrome")

-- Add download support
local downloads = require("downloads")
local downloads_chrome = require("downloads_chrome")

downloads.default_dir = os.getenv("HOME") .. "/downloads"

-- Add vimperator-like link hinting & following
local follow = require("follow")

-- Add command history
local cmdhist = require("cmdhist")

-- Add search mode & binds
local search = require("search")

-- Add ordering of new tabs
local taborder = require("taborder")

-- Save web history
local history = require("history")
local history_chrome = require("history_chrome")

local help_chrome = require("help_chrome")
local binds_chrome = require("binds_chrome")

-- Add command completion
local completion = require("completion")

local follow_selected = require("follow_selected")
local go_input = require("go_input")
local go_next_prev = require("go_next_prev")
local go_up = require("go_up")

-- Filter Referer HTTP header if page domain does not match Referer domain
require_web_module("referer_control_wm")

local error_page = require("error_page")

-- Add userstyles loader
local styles = require("styles")

-- Add a stylesheet when showing images
local image_css = require("image_css")

-- Add a new tab page
local newtab_chrome = require("newtab_chrome")

-- Put "userconf.lua" in your Luakit config dir with your own tweaks; if this is
-- permanent, no need to copy/paste/modify the default rc.lua whenever you
-- update Luakit.
if pcall(function()
    lousy.util.find_config("userconf.lua")
end) then
    require("userconf")
end

-----------------------------
-- End user script loading --
-----------------------------
window.new(uris)
-- vim: et:sw=4:ts=8:sts=4:tw=80
