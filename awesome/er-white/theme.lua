
---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "play 10"

theme.bg_normal     = "#F1F1F1"
theme.bg_focus      = "#00557F" --"#2400C7" --"#76A1DE" --#6992C7
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#4A5F78"


theme.fg_normal     = "#000000" --also "#eaeaea" for a bit brighter font or "#d4d4d4"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
-- theme.border_normal = "#000000"
-- theme.border_focus  = "#535d6c"
theme.border_normal = "#dddddd"
theme.border_focus = "#4C89DE" --#6992C7
theme.border_marked = "#FDF6E3"

-- Additional tasklist settings (override tasklist defaults):
theme.tasklist_fg_focus = "#2400C7" --#6992C7
theme.tasklist_bg_focus = "#F1F1F1"

-- There are other variable sets
-- overriding the defaulter one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- theme.taglist_squares_sel   = "/home/klazutin/.config/awesome/themes/er-white/taglist/squaref.png"
-- theme.taglist_squares_unsel = "/home/klazutin/.config/awesome/themes/er-white/taglist/square.png"
theme.taglist_fg_occupied = "#2400C7" --"#4C89DE"

theme.tasklist_floating_icon = "/home/klazutin/.config/awesome/themes/er-white/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/home/klazutin/.config/awesome/themes/er-white/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = "/home/klazutin/.config/awesome/themes/er-white/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/home/klazutin/.config/awesome/themes/er-white/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/home/klazutin/.config/awesome/themes/er-white/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/home/klazutin/.config/awesome/themes/er-white/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/home/klazutin/.config/awesome/themes/er-white/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/home/klazutin/.config/awesome/themes/er-white/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/home/klazutin/.config/awesome/themes/er-white/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/home/klazutin/.config/awesome/themes/er-white/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/home/klazutin/.config/awesome/themes/er-white/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = "/home/klazutin/.config/awesome/themes/er-white/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "awsetbg /home/klazutin/.config/awesome/themes/er-white/background.png" }

-- You can use your own layout icons like this:
theme.layout_fairh = "/home/klazutin/.config/awesome/themes/er-white/layouts/fairh.png"
theme.layout_fairv = "/home/klazutin/.config/awesome/themes/er-white/layouts/fairv.png"
theme.layout_floating  = "/home/klazutin/.config/awesome/themes/er-white/layouts/floating.png"
theme.layout_magnifier = "/home/klazutin/.config/awesome/themes/er-white/layouts/magnifier.png"
theme.layout_max = "/home/klazutin/.config/awesome/themes/er-white/layouts/max.png"
theme.layout_fullscreen = "/home/klazutin/.config/awesome/themes/er-white/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/klazutin/.config/awesome/themes/er-white/layouts/tilebottom.png"
theme.layout_tileleft   = "/home/klazutin/.config/awesome/themes/er-white/layouts/tileleft.png"
theme.layout_tile = "/home/klazutin/.config/awesome/themes/er-white/layouts/tile.png"
theme.layout_tiletop = "/home/klazutin/.config/awesome/themes/er-white/layouts/tiletop.png"
theme.layout_spiral  = "/home/klazutin/.config/awesome/themes/er-white/layouts/spiral.png"
theme.layout_dwindle = "/home/klazutin/.config/awesome/themes/er-white/layouts/dwindle.png"

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
