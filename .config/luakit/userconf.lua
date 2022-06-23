local lousy = require("lousy")

lousy.widget.tab.label_format = "{title}"

local modes = require("modes")
-- Binds
modes.remap_binds("normal", {
    { "<control-h>", "H", true },
    { "<control-l>", "L", true },
    { "<Mouse8>", "H", true },
    { "<Mouse9>", "L", true },
})

modes.add_binds("normal", {
    {
        "y",
        "Hint all links (as defined by the follow.selectors.uri selector) and set the clipboard selection to the matched elements URI.",
        function(w)
            w:set_mode("follow", {
                prompt = "yank",
                selector = "uri",
                evaluator = "uri",
                func = function(uri)
                    assert(type(uri) == "string")
                    uri = uri:gsub(" ", "%%20"):gsub("^mailto:", "")
                    luakit.selection.clipboard = uri
                    w:notify("Yanked uri: " .. uri, false)
                end,
            })
        end,
    },
    {
        "x",
        "Hint all links and open the video behind that link externally with MPV.",
        function(w)
            local video_cmd_fmt = "mpv '%s'"
            w:set_mode("follow", {
                prompt = "open with MPV",
                selector = "uri",
                evaluator = "uri",
                func = function(uri)
                    assert(type(uri) == "string")
                    luakit.spawn(string.format(video_cmd_fmt, uri))
                    w:notify("Launched MPV")
                end,
            })
        end,
    },
    {
        "v",
        "Play video in page",
        function(w)
            local view = w.view
            local uri = view.hovered_uri or view.uri
            if uri then
                luakit.spawn(string.format("mpv %s", uri))
            end
        end,
    },
    {
        "<Control-c>",
        "Copy selected text.",
        function()
            luakit.selection.clipboard = luakit.selection.primary
        end,
    },
})

local settings = require("settings")

modes.add_binds("all", {
    { "<Scroll>", "Scroll the current page.", function (w, o)
        w:scroll { yrel = settings.window.scroll_step * o.dy }
    end },
})

settings.webview.enable_smooth_scrolling = false
settings.window.home_page = "file://"
    .. os.getenv("HOME")
    .. "/projects/homepage/index.html"

local select = require("select")

select.label_maker = function()
    local chars = charset("ASDFGHJKL")
    return trim(sort(reverse(chars)))
end

local engines = settings.window.search_engines

engines.searx = "https://searx.be/?q=%s"
engines.default = engines.searx

local window = require("window")
window.add_signal("init", function(w)
    w.update_sbar_visibility_old = w.update_sbar_visibility
    w.update_sbar_visibility = function(w)
        w:update_sbar_visibility_old()
        if w.bar_layout.visible_child == w.sbar.ebox then
            w.bar_layout.visible = false
        end
    end
end)
