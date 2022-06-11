local lousy = require("lousy")

lousy.widget.tab.label_format = "{title}"

local modes = require("modes")
-- Binds
modes.remap_binds("normal", {
    { "<control-h>", "H", true },
    { "<control-l>", "L", true },
})

modes.add_binds(
    "normal",
    {
        {
            "<Control-c>",
            "Copy selected text.",
            function()
                luakit.selection.clipboard = luakit.selection.primary
            end,
        },
    }
)

modes.add_binds("normal", {
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
})

local settings = require("settings")
settings.window.home_page = "file:///home/oliver/projects/homepage/index.html"

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
