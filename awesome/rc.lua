-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
-- Theme handling library
require("beautiful")
-- Notification library
-- require("naughty")
-- Scratchpad
--local scratch = require("scratch")
--require("menubar")
--menubar.cache_entries = true
--menubar.app_folders = { "/usr/share/applications/" }
--menubar.show_categories = true   -- Change to false if you want only programs to appear in the menu
--menubar.set_icon_theme("Faenza")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/klazutin/.config/awesome/themes/er-white/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.spiral,
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- tags = {}
-- for s = 1, screen.count() do
    -- Each screen has its own tag table.
--     tags[s] = awful.tag({ "one", "two", "three", "four", "five", "six", "seven", "eight"}, s, layouts[1])
-- end
-- }}}

-- {{{ Tags
tags = {
	names  = { " 1 ", " 2 ", " 3 ", " 4 ", " Q ", " W ", " E ", " R " }, 
        layout = { layouts[1], layouts[3], layouts[1], layouts[1],
                   layouts[1], layouts[1], layouts[1], layouts[1]
                  }}
        for s = 1, screen.count() do
            tags[s] = awful.tag(tags.names, s, tags.layout)
        end
--- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

powermenu = {
   { "lock", "slimlock" },
   { "suspend", "systemctl suspend" },
   { "reboot", "reboot" },
   { "shutdown", "shutdown -h now" }
}

-- Applications menu
--require('freedesktop.utils')
--freedesktop.utils.terminal = terminal  -- default: "xterm"
--freedesktop.utils.icon_theme = 'gnome' -- look inside /usr/share/icons/, default: nil (don't use icon theme)
--require('freedesktop.menu')
--menu_items = freedesktop.menu.new() 

mymainmenu = awful.menu({ items = { 
								    { "&Caja", "caja"},
				    				{ "&Firefox", "firefox-beta-bin"},
                                    { "&Keepassx", "keepassx"},
                                    { "&VMWare", "vmware"},
                                    { "&Truecrypt", "truecrypt"},
									{ "Chrome &Inconginto", "google-chrome --incognito"},
                                    { "Terminal", terminal },
                                    { "---" },
--									{ "Applications", menu_items },
                                    { "awesome", myawesomemenu},
                                    { "Power", powermenu }
                                  }, width = 150
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox

-- Close button widget
--closebutton = widget({type = "imagebox"})
--closebutton.image = image(beautiful.titlebar_close_button_focus)
--closebutton:buttons(awful.util.table.join(
--                    awful.button({ }, 1, function() client.focus:kill() end)
--        ))

-- XFCE AppLauncher widget
--applaunch = widget({type = "imagebox"})
--applaunch.image = image("/usr/share/icons/hicolor/16x16/apps/xfce4-panel-menu.png")
--applaunch:buttons(awful.util.table.join(
--					awful.button({ }, 1, function() awful.util.spawn_with_shell("xfce4-appfinder") end)
--		))

-- Keyboard layout widget
kbdwidget = widget({type = "textbox", name = "kbdwidget"})
--kbdwidget.border_width = 1
--kbdwidget.border_color = beautiful.fg_normal
kbdwidget.text = " EN "
dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.add_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    lts = {[0] = "EN", [1] = "RU"}
    kbdwidget.text = " "..lts[layout].." "
    end
)

kbdwidget:buttons(awful.util.table.join(
		  awful.button({ }, 1, function () awful.util.spawn_with_shell("dbus-send --dest=ru.gentoo.KbddService /ru/gentoo/KbddService ru.gentoo.kbdd.next_layout") end)
))


-- Backlight widget
backlight=widget ({type = "textbox"})
backlight.text = "<span font_desc='Sans 15' weight='bold'>☼</span>"
backlight.buttons(backlight,{ button({ }, 4, function () backlight_set("1") end),
            button({ }, 5, function () backlight_set("-1") end),
     })

function backlight_set(value)
  local file=assert(io.open("/sys/class/backlight/acpi_video0/brightness", "w+"))
  local cur=""
  cur = file:read()
  file:write(tonumber(cur)+value)
  file:close()
--  local file=io.open("/sys/class/backlight/acpi_video0/brightness", "rw")
--  local cur=""
--  cur = file:read()
--  backlight.text=tonumber(cur)+value
end


-- Separator widget
separator= widget ({type = "textbox"})
--separator.text= " "
separator.text = ' <span font_desc="Sans 6" color="grey">|</span> '


-- Gmail widget
gmail= widget ({type="textbox"})
gmail.text = '<span font_desc="Sans 16">✉</span>'

-- function hook_gmail(widget)
--   local f = os.execute("time curl -u klazutin:jxvrrlpardcqrhpv --silent 'https://mail.google.com/mail/feed/atom' | grep -c '<entry>'")
--   if f==0 then
--     widget.text = '<span font_desc="Sans 16" color="#ff0000">✉</span>'
--   else
--     widget.text = '<span font_desc="Sans 16">✉</span>'
--   end
-- end


-- Battery power widget
power= widget({ type = "textbox", name = "power" })
power.text= 'power'

function hook_power (widget)
   local fh= io.open("/sys/class/power_supply/BAT0/power_now", "r")
   local fx= io.open("/sys/class/power_supply/BAT0/status", "r")
   local state=fx:read()
   if state=="Charging" or state=="Full" or state=="Unknown" then
      widget.text='<span font_desc="Sans 14">⚡</span>'      
   else
      local value=""
      if fh then
         value=tonumber(fh:read()/1000000)
      end
      if tonumber(value) < 10 then
          widget.text= string.format("%.3f", value).."W"
      else
          widget.text= string.format("%.2f", value).."W"
      end
   end
   fh:close()
   fx:close()
end


-- CPU Temperature widget and Fan menu
fanmenu = {
   { "level auto", "/home/klazutin/fanctl.sh auto" },
   { "",""},
   { "level 0", "/home/klazutin/fanctl.sh 0" },
   { "level 1", "/home/klazutin/fanctl.sh 1" },
   { "level 2", "/home/klazutin/fanctl.sh 2" },
   { "level 3", "/home/klazutin/fanctl.sh 3" },
   { "level 4", "/home/klazutin/fanctl.sh 4" },
   { "level 5", "/home/klazutin/fanctl.sh 5" },
   { "level 6", "/home/klazutin/fanctl.sh 6" },
   { "level 7", "/home/klazutin/fanctl.sh 7" },
   { "",""},
   { "level full", "/home/klazutin/fanctl.sh full-speed" },
   }

temp = widget({ type = "textbox", name = "temp" })
temp.text = 'temp'
tempmenu = awful.menu.new( { items = fanmenu }  )
temp.buttons(temp,{ button({ }, 1, function () awful.menu.toggle(tempmenu) end) })

function hook_temp (widget)
   local value=""
   local fk= io.open("/proc/acpi/ibm/thermal", "r")
   if fk then
      value=fk:read()
      fk:close()
      value=string.match(value, "%d+")
   end
   if tonumber(value) > 70 then
      widget.text ="<span color='red'>"..value.."°".."</span>"
   else
      widget.text = value.."°"
   end
end

temp_tooltip = awful.tooltip({
	objects = { temp },
	timer_function = function ()
		os.execute ("sleep 0.5s")
		local value=""
		local f = io.popen("cat /proc/acpi/ibm/fan | grep level:")
		if f then
			value = f:read()
			f:close()
		end
		return value
	end,
})


-- Fraxcpu widget and governor menu
--fraxcpumenu = {}
--local fh= io.open("/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors", "r")
--if fh ~= nil then 
--   govstr= fh:read()
--   fh:close()
--   local i= 1
--   for w in string.gmatch(govstr, "%a+") do
--      fraxcpumenu[i]= { w, "sudo cpufreq-set -r -g "..w}
--      i= i + 1
--   end
--end
--fraxcpumenu = awful.menu.new( { items= fraxcpumenu }  )
--
--fraxcpu=  widget({ type = "textbox", name = "fraxcpu", align = "right" })
--fraxcpu.text= 'fraxcpu'
--
--fraxcpu.buttons(fraxcpu,{ button({ }, 1, function () awful.menu.toggle(fraxcpumenu) end),
--        button({ }, 2, function () hook_fraxcpu(fraxcpu) end),
--        button({ }, 3, function () hook_fraxcpu(fraxcpu) end) })



-- Battery widget
battery=widget({ type = "textbox", name = "battery" })
battery.text="..."

function hook_battery (widget)
   local ffull=io.open("/sys/class/power_supply/BAT0/energy_full", "r")
   local full=ffull:read()
   local fnow=io.open("/sys/class/power_supply/BAT0/energy_now", "r")
   local now=fnow:read()
   local percent=""
   percent=math.floor((now/full)*100)
   if percent > 10 and percent < 15 then
     widget.text="<span color='red' weight='bold'>"..percent.."%".."</span>"
   elseif percent <= 10 then
     widget.text="<span bgcolor='red' color='black' weight='bold'>"..percent.."%".."</span>"
   else
     widget.text="<span weight='bold'>"..percent.."%".."</span>"
     
   end
   ffull:close()
   fnow:close()
end

battery_tooltip = awful.tooltip({
	objects = { battery },
	timer_function = function ()
		os.execute ("sleep 0.5s")
		local energy=""
		local power=""
		local per=""
		local f = io.popen("cat /sys/class/power_supply/BAT0/energy_now")
		if f then
			energy = f:read()
			f:close()
		end
		local g = io.popen("cat /sys/class/power_supply/BAT0/power_now")
		if g then
			power = g:read()
			g:close()
		end
		if power == "0" then
			return "Charging"
		else
			per = energy/power
			return string.format ("%s %i:%02i", "Time remaining: ", math.floor(per), math.floor((per*60)%60))
		end
	end,
})


-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })
mytextclock:buttons(awful.util.table.join(
                    awful.button({ }, 1, function() awful.util.spawn_with_shell("LC_TIME='ru_RU.UTF-8' gsimplecal") end)
		            ))

-- Create a systray
mysystray = widget({ type = "systray" })

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
				    awful.button({ }, 2, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
--                    awful.button({ }, 5, awful.tag.viewnext),
--                    awful.button({ }, 4, awful.tag.viewprev)
                    awful.button({ }, 5, function ()
			    if awful.tag.getidx() ~= keynumber then
				    awful.tag.viewnext()
			    end
		    end
		    ),
		    awful.button({ }, 4, function ()
			    if awful.tag.getidx() ~= 1 then
				    awful.tag.viewprev()
			    end
		    end
		    )
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
		     awful.button({ }, 2, function (c)
			     		      c:kill() 
			     		  end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
						   awful.button({ }, 2, function () mymainmenu:toggle() end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "18" })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylayoutbox[s],
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
--	closebutton,
        mytextclock,
--        separator,
--        separator,
--        fraxcpu,
        separator,
        battery,
        separator,
        power,
        separator,
        temp,
        separator,
        kbdwidget,
        separator,
	gmail,
	separator,
        backlight,
        separator,
        s == 1 and mysystray or nil,
--		applaunch,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({					  }, "#160",   		function () awful.util.spawn("slimlock") end),
    awful.key({					  }, "#244",   		function () awful.util.spawn("xset dpms force off") end),
    awful.key({ modkey,           }, "Left",   		awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  		awful.tag.viewnext       ),
    awful.key({ modkey,           }, "`", 	   		awful.tag.history.restore),
    awful.key({ "Mod1"	 	 	  }, "F2",	  		function () awful.util.spawn_with_shell("xfce4-appfinder -c") end),
    awful.key({ modkey, "Control" }, "p",			function () awful.util.spawn("/home/klazutin/pidgin-send.sh") end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "[", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "u", awesome.restart),
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "u",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
--    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end),
    awful.key({ "Mod1"  	  }, "F4",     function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "u",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,		  }, "d",      function (c) scratch.pad.set(c, 0.60, 0.60, true) end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
--for i = 1, keynumber do
keyarray = { 10, 11, 12, 13, 24, 25, 26, 27 }
for i, k in ipairs(keyarray) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" ..  k,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. k,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. k,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. k,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false  } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "Pidgin" },
      properties = { floating = true } },
    { rule = { class = "Skype" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "appfinder" },
      properties = { floating = true } },
	{ rule = { class = "Xfce4-panel" },
      properties = { floating = true } },
    { rule = { class = "Gsimplecal" },
      properties = { border_width = "0" } },
    { rule = { class = "Gimp" },
      properties = { floating = true } },
    { rule = { class = "Terminal" },
      properties = { size_hints_honor = false } },
    { rule = { class = "Vmware", type = "normal" },
      properties = { tag = tags [1][4],
  					 maximized_vertical = true,
				 	 maximized_horizontal = true } },
    { rule = { class = "Firefox", instance = "Navigator" },
      properties = { tag = tags[1][1],
	  				 maximized_vertical = true,
					 maximized_horizontal = true, } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
-- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)
    awful.placement.no_offscreen(c)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)  
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
--client.add_signal("focus", 
--	function(c) 
--		if c.maximized_horizontal == true and c.maximized_vertical == true then
--			c.border_width = "0"
--		else
--			c.border_width = beautiful.border_width
--		end
--	end)

size_hints_honor = false 

-- Fraxcpu hook
--fraxcpuupd=1
--function hook_fraxcpu (tbw)
--   if not fraxcpuupd then return(nil) end
--   local freq=""
--   local gov=""
--   local suffix="GHz"
--   local fh= io.open("/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor", "r")
--   if fh then
--      gov= fh:read()
--      fh:close()
--   end
--   if gov=="ondemand" then
--      gov="O"
--   elseif gov=="conservative" then
--      gov="C"
--   elseif gov=="performance" then
--      gov="P"
--   end
--   fh= io.open("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq", "r")
--   if fh then
--      freq= fh:read()
--      fh:close()
--      freq= tostring(math.ceil(tonumber(freq)/1000))
--   else
--      fraxcpuupd= nil
--      fh= io.open("/proc/cpuinfo", "r")
--      if fh then
--   for l in fh:lines() do
--      freq= string.match(l, '^%s*cpu MHz%s*:%s*([0-9]+)')
--      if freq ~= nil then break end
--      freq= ""
--   end
--      end
--   end
--   freq=tonumber(freq)
----   if freq > 1000 then
--      freq = string.format("%.1f", freq/1000)
--      suffix = "GHz"
----   end
--   tbw.text= gov..freq..suffix
--end


-- {{{ A sort of an autostart:
function run_once(prg)
    if not prg then
        do return nil end
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x '" .. prg .. "' || (" .. prg .. ")")
end

run_once("skype")
run_once("pidgin")
run_once("kbdd")
run_once("volumeicon")
run_once("dropboxd")
run_once("transmission-gtk -m")
run_once("parcellite")
run_once("gmail")
-- }}}


awful.hooks.timer.register(1, function ()
    hook_power(power)
end)

awful.hooks.timer.register(5, function ()
    hook_temp(temp)
end)

awful.hooks.timer.register(60, function ()
    hook_battery(battery)
end)

-- Signal to remove borders from maximized and single windows
--for s = 1, screen.count() do screen[s]:add_signal("arrange", function ()
--    local clients = awful.client.visible(s)
--                                                                                                                                                            
--    for _, c in pairs(clients) do
--        if c.maximized_horizontal and c.maximized_vertical then
--            c.border_width = 0 
--        elseif #clients == 1 then
--            c.border_width = 0 
--        else
--            c.border_width = beautiful.border_width
--        end 
--    end 
--  end)
--end
--
for s = 1, screen.count() do screen[s]:add_signal("arrange", function ()
    local clients = awful.client.visible(s)
    for _, c in pairs(clients) do
		if c.fullscreen then
			c.border_width = 0
		elseif c.maximized_horizontal and c.maximized_vertical then
            c.border_width = 0 
--        else
--            c.border_width = beautiful.border_width
        end 
    end 
  end)
end

