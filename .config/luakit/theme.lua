--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "Cozette"
theme.fg   = "#d8d8d8"
theme.bg   = "#0c0c0d"

-- Genaral colours
theme.success_fg = "#0f0"
theme.loaded_fg  = "#33AADD"
theme.error_fg = "#FFF"
theme.error_bg = "#F00"

-- Warning colours
theme.warning_fg = "#F00"
theme.warning_bg = "#FFF"

-- Notification colours
theme.notif_fg = "#444"
theme.notif_bg = "#FFF"

-- Menu colours
theme.menu_fg                   = "#d8d8d8"
theme.menu_bg                   = "#0c0c0d"
theme.menu_selected_fg          = "#d8d8d8"
theme.menu_selected_bg          = "#141414"
theme.menu_title_bg             = "#0c0c0d"
theme.menu_primary_title_fg     = "#fff"
theme.menu_secondary_title_fg   = "#666"

theme.menu_disabled_fg = "#999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = "#060"
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = '#000'
theme.proxy_active_menu_bg      = '#FFF'
theme.proxy_inactive_menu_fg    = '#888'
theme.proxy_inactive_menu_bg    = '#FFF'

-- Statusbar specific
theme.sbar_fg         = "#fff"
theme.sbar_bg         = "#000"

-- Downloadbar specific
theme.dbar_fg         = "#fff"
theme.dbar_bg         = "#000"
theme.dbar_error_fg   = "#F00"

-- Input bar specific
theme.ibar_fg           = "#d8d8d8"
theme.ibar_bg           = "#0c0c0d"

-- Tab label
theme.tab_fg            = "#888"
theme.tab_bg            = "#0c0c0d"
theme.tab_hover_bg      = "#292929"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#fff"
theme.selected_bg       = "#0c0c0d"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#0c0c0d"

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#0F0"
theme.notrust_fg        = "#F00"

-- Follow mode hints
theme.hint_font = "10pt monospace"
theme.hint_fg = "#2d2d2d"
theme.hint_bg = "#ffcc66"
theme.hint_border = "1px dashed #ffcc66"
theme.hint_opacity = "0.9"
theme.hint_overlay_bg = "rgba(255,255,153,0.5)"
theme.hint_overlay_border = "1px dotted #0c0c0d"
theme.hint_overlay_selected_bg = "rgba(0,255,0,0.0)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = "#d8d8d8", bg = "#0c0c0d" }
theme.warn = { fg = "#F00", bg = "#d8d8d8" }
theme.error = { fg = "#d8d8d8", bg = "#F00" }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#E8E8E8", fg = "#17181C", link = "#03678D" }
theme.gopher_dark  = { bg = "#17181C", fg = "#E8E8E8", link = "#f90" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
