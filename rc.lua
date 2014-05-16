-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Require vicious
local vicious = require("vicious")

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
    awesome.connect_signal("debug::error", function (err)
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
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/usr/share/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,       --1
    awful.layout.suit.tile,           --2
    awful.layout.suit.tile.left,      --3 
    awful.layout.suit.tile.bottom,    --4
    awful.layout.suit.tile.top,       --5
    awful.layout.suit.fair,           --6
    awful.layout.suit.fair.horizontal,--7
    awful.layout.suit.spiral,         --8
    awful.layout.suit.spiral.dwindle, --9
    awful.layout.suit.max,            --10
    awful.layout.suit.max.fullscreen, --11
    awful.layout.suit.magnifier       --12
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- Test tag --
tags = {
   settings = {
     { names  = { "main", "cmd", "audio", "file", "ide", "www", "image", "visual", "game", "test" },
       layout = { layouts[4], layouts[4], layouts[5], layouts[3], layouts[10],layouts[3], layouts[9], layouts[10], layouts[10], layouts[5] }
     },
     { names  = { "www",  6, 7,  "media" },
       layout = { layouts[4], layouts[2], layouts[2], layouts[5] }
 }}}
 
 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.settings[s].names, s, tags.settings[s].layout)
 end

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox

-- Declaring My test spacers --
bracketR = wibox.widget.textbox()
bracketR:set_text(" ]")

bracketL = wibox.widget.textbox()
bracketL:set_text("[ ")

space = wibox.widget.textbox()
space:set_text(" ")

sd = wibox.widget.textbox()
sd:set_text(" / ")

-- Declaring My text varibles
volText = wibox.widget.textbox()
volText:set_text("Volume: ")

cpuT2 = wibox.widget.textbox()
cpuT2:set_text("CPU: ")

ramText = wibox.widget.textbox()
ramText:set_text("RAM: ")

-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create My volume widget
volume = wibox.widget.textbox()

-- Create My CPU widget
cpu = wibox.widget.textbox()
--vicious.register( cpu, vicious.widgets.cpu, "CPU1:$2% CPU2:$3% CPU3:$4% CPU4:$5% CPU5:$6% CPU6:$7% CPU7:$8% CPU8:$9%", 2)
--vicious.register( cpu, vicious.widgets.cpu, "CPU1:$cpuGph1% CPU2:$3% CPU3:$4% CPU4:$5% CPU5:$6% CPU6:$7% CPU7:$8% CPU8:$9%", 2)

-- My test cpu graph
vicious.cache(vicious.widgets.cpu)

  --CPU1 Graph 
  -- Initializ widget
cpuGph1 = awful.widget.graph()

  -- Graph properties
cpuGph1:set_width(75)
cpuGph1:set_height(30)
cpuGph1:set_border_color("#222222")
cpuGph1:set_background_color("#000000")
cpuGph1:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})

  --}}

  --CPU2 Graph 
  -- Initializ widget
cpuGph2 = awful.widget.graph()
  -- Graph properties
cpuGph2:set_width(75)
cpuGph2:set_height(30)
cpuGph2:set_border_color("#222222")
cpuGph2:set_background_color("#000000")
cpuGph2:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU3 Graph 
  -- Initializ widget
cpuGph3 = awful.widget.graph()
  -- Graph properties
cpuGph3:set_width(75)
cpuGph3:set_height(30)
cpuGph3:set_border_color("#222222")
cpuGph3:set_background_color("#000000")
cpuGph3:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU4 Graph 
  -- Initializ widget
cpuGph4 = awful.widget.graph()
  -- Graph properties
cpuGph4:set_width(75)
cpuGph4:set_height(30)
cpuGph4:set_border_color("#222222")
cpuGph4:set_background_color("#000000")
cpuGph4:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU5 Graph 
  -- Initializ widget
cpuGph5 = awful.widget.graph()
  -- Graph properties
cpuGph5:set_width(75)
cpuGph5:set_height(30)
cpuGph5:set_border_color("#222222")
cpuGph5:set_background_color("#000000")
cpuGph5:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU6 Graph 
  -- Initializ widget
cpuGph6 = awful.widget.graph()
  -- Graph properties
cpuGph6:set_width(75)
cpuGph6:set_height(30)
cpuGph6:set_border_color("#222222")
cpuGph6:set_background_color("#000000")
cpuGph6:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU7 Graph 
  -- Initializ widget
cpuGph7 = awful.widget.graph()
  -- Graph properties
cpuGph7:set_width(75)
cpuGph7:set_height(30)
cpuGph7:set_border_color("#222222")
cpuGph7:set_background_color("#000000")
cpuGph7:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}

  --CPU8 Graph 
  -- Initializ widget
cpuGph8 = awful.widget.graph()
  -- Graph properties
cpuGph8:set_width(75)
cpuGph8:set_height(30)
cpuGph8:set_border_color("#222222")
cpuGph8:set_background_color("#000000")
cpuGph8:set_color({ type = "linear", from = { 75,0 }, to = { 75,30 }, stops = { {0, "#FF0000"}, {0.5, "#FFFF00"},
                 {1, "#00FF00" }}})
  --}}



-- Register CPU Graph widgets
vicious.register(cpuGph1, vicious.widgets.cpu, "$2", 1)
vicious.register(cpuGph2, vicious.widgets.cpu, "$3", 1)
vicious.register(cpuGph3, vicious.widgets.cpu, "$4", 1)
vicious.register(cpuGph4, vicious.widgets.cpu, "$5", 1)
vicious.register(cpuGph5, vicious.widgets.cpu, "$6", 1)
vicious.register(cpuGph6, vicious.widgets.cpu, "$7", 1)
vicious.register(cpuGph7, vicious.widgets.cpu, "$8", 1)
vicious.register(cpuGph8, vicious.widgets.cpu, "$9", 1)


-- Create My RAM widget
ram = wibox.widget.textbox()
vicious.register( ram, vicious.widgets.mem, "$2MB", 3)

-- Create My MPD widget
-- Icons should be placed in $HOME/awesome/icons
-- or change the code to suit your needs
mpdAtr = wibox.widget.imagebox()
vicious.register(mpdAtr, vicious.widgets.mpd)
mpdAtr:set_image(awful.util.getdir("config") .. "/icons/prev.png")
mpdAtr:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn("ncmpcpp prev", false) end)
))

mpdDet = wibox.widget.imagebox()
vicious.register(mpdDet, vicious.widgets.mpd)
mpdDet:set_image(awful.util.getdir("config") .. "/icons/stop.png")
mpdDet:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn("ncmpcpp stop", false) end)
))

mpdPau = wibox.widget.imagebox()
vicious.register(mpdPau, vicious.widgets.mpd)
mpdPau:set_image(awful.util.getdir("config") .. "/icons/pause.png")
mpdPau:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn("ncmpcpp pause", false) end)
))

mpdRep = wibox.widget.imagebox()
vicious.register(mpdRep, vicious.widgets.mpd)
mpdRep:set_image(awful.util.getdir("config") .. "/icons/play.png")
mpdRep:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn("ncmpcpp play", false) end)
))

mpdSig = wibox.widget.imagebox()
mpdSig:set_image(awful.util.getdir("config") .. "/icons/next.png")
mpdSig:buttons(awful.util.table.join(
  awful.button({ }, 1, function () awful.util.spawn("ncmpcpp next", false) end)
))

mpd = wibox.widget.textbox()
vicious.register(mpd, vicious.widgets.mpd,
  function (widget, args)
      if args["{state}"] == "Stop" then
            return "Done"
      elseif args["{state}"] == "Pause" then
            return "Paused"
      elseif args["{state}"] == "Play" then
            return args["{Title}"].. ' - ' .. args["{Artist}"]
      end
  end, 1)
colMpd = wibox.widget.background()
colMpd:set_widget(mpd)
colMpd:set_bg("#84A157")

mpdIco = wibox.widget.imagebox()
mpdIco:set_image(awful.util.getdir("config") .. "/icons/note.png")
colMpdIco = wibox.widget.background()
colMpdIco:set_widget(mpdIco)
colMpdIco:set_bg("#84A157")

-- My background_timer
background_timers = {}                                                             
                                                                                  
function run_background(cmd,funtocall)                                             
   local r = io.popen("mktemp")                                                   
   local logfile = r:read("*line")                                                
   r:close()                                                                      
                                                                                  
   cmdstr = cmd .. " &> " .. logfile .. " & "                                     
   local cmdf = io.popen(cmdstr)                                                  
   cmdf:close()                                                                   
   background_timers[cmd] = {                                                     
       file  = logfile,                                                           
       timer = timer{timeout=1}                                                   
   }                                                                              
   background_timers[cmd].timer:connect_signal("timeout",function()                   
       local cmdf = io.popen("pgrep -f '" .. cmd .. "'")                          
       local s = cmdf:read("*all")                                                
       cmdf:close()                                                               
       if (s=="") then                                                            
           background_timers[cmd].timer:stop()                                    
           local lf = io.open(background_timers[cmd].file)                        
           funtocall(lf:read("*all"))                                             
           lf:close()
           io.popen("rm " .. background_timers[cmd].file)                                                            
       end                                                                        
   end)                                                                           
   background_timers[cmd].timer:start()                                           
end
run_background("ping -c 5 www.google.hu",function(txt)                              
   naughty.notify({text=txt})                                                      
end)
-- Volume ICON
--volumeIco = wibox.widget.imagebox()
--volumeIco:set_image(awful.util.getdir("config") .. "/icons/spkr_01.png")

-- Register My volume widget
vicious.register( volume, vicious.widgets.volume, "$1%", 1, "Master")

-- Create a wibox for each screen and add it
mywibox = {}
mywiboxbottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
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
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    mywiboxbottom[s] = awful.wibox({ position = "bottom", screen = 2, height = 25 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

-- My Widgets bottom left
    local left_layoutbottom = wibox.layout.fixed.horizontal()
    left_layoutbottom:add(bracketL)
--    left_layoutbottom:add(volumeIco)
    left_layoutbottom:add(volText)
    left_layoutbottom:add(volume)
    left_layoutbottom:add(bracketR)
    left_layoutbottom:add(space)
    left_layoutbottom:add(bracketL)
    left_layoutbottom:add(cpu)
    left_layoutbottom:add(bracketR)
    left_layoutbottom:add(space)
    left_layoutbottom:add(bracketL)
    left_layoutbottom:add(ramText)
    left_layoutbottom:add(ram)
    left_layoutbottom:add(bracketR)
    left_layoutbottom:add(bracketL)
    left_layoutbottom:add(mpdAtr)
    left_layoutbottom:add(mpdDet)
    left_layoutbottom:add(mpdPau)
    left_layoutbottom:add(mpdRep)
    left_layoutbottom:add(mpdSig)
    left_layoutbottom:add(mpdIco)
    left_layoutbottom:add(mpd)

-- My widgets bottom right
    local right_layoutbottom = wibox.layout.fixed.horizontal()
    --right_layoutbottom:add(mpdAtr)
    --right_layoutbottom:add(mpdDet)
    --right_layoutbottom:add(mpdPau)
    --right_layoutbottom:add(mpdIco)
    --right_layoutbottom:add(mpd)
    --right_layoutbottom:add(keydoc)
    right_layoutbottom:add(cpuGph1)
    right_layoutbottom:add(cpuGph2)
    right_layoutbottom:add(cpuGph3)
    right_layoutbottom:add(cpuGph4)
    right_layoutbottom:add(cpuGph5)
    right_layoutbottom:add(cpuGph6)
    right_layoutbottom:add(cpuGph7)
    right_layoutbottom:add(cpuGph8)

-- My widgets all together bottom
    local layoutbottom = wibox.layout.align.horizontal()
    layoutbottom:set_left(left_layoutbottom)
    layoutbottom:set_right(right_layoutbottom)

    mywiboxbottom[s]:set_widget(layoutbottom)

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

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
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

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
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() awful.util.spawn("ncmpcpp toggle", true) end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
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
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
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
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[2][1]}},
    -- Set Firefox to always map on tags number 2 of screen 1.
     --{ rule = { class = "Firefox" },
       --properties = { tag = tags["www"][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

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

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
