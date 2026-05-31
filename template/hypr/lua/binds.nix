{config, ...}: let
  inherit (config.player) cmd class cmdGame;
  inherit (config.wayland.windowManager.hyprland) liveWallpaper;
in {
  xdg.configFile."hypr/lua/binds.lua".text =
    /*
    Lua
    */
    ''
      local browser = Browser
      local discord = Discord
      local editor = Editor
      local files = Files
      local filest = Filest
      local menu = Menu
      local mod = Mod
      local moda = Moda
      local modc = Modc
      local mods = Mods
      local player = Player
      local playerctl = Playerctl
      local scr = Scr
      local term = Term

      local function layout_bind(bind_table)
      return function()
        local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

        if not workspace then
                return
        end

        local layout = workspace.tiled_layout

        if bind_table[layout] then
                hl.dispatch(bind_table[layout])
        end
      end
      end


      for i = 1, 10 do
      local key = i % 10 -- 10 maps to key 0
      hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
      hl.bind(mods .. " + " .. key, hl.dsp.window.move({ workspace = i }))
      end

      hl.bind(mod .. " + F9", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(mod .. " + F10", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(mod .. " + F12", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(moda .. " + G", hl.dsp.workspace.toggle_special("game"))
      hl.bind(moda .. " + V", hl.dsp.workspace.toggle_special("video"))
      hl.bind(moda .. " + W", hl.dsp.workspace.toggle_special("win"))
      hl.bind(moda .. " + G", hl.dsp.window.move({ workspace = "special:game" }))
      hl.bind(moda .. " + V", hl.dsp.window.move({ workspace = "special:video" }))
      hl.bind(moda .. " + W", hl.dsp.window.move({ workspace = "special:win" }))

      hl.bind(
      mod .. " + U",
      layout_bind({
        scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
        dwindle = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
        monocle = hl.dsp.layout("cycleprev"), -- Monocle and master: cycle prev window
        master = hl.dsp.layout("cycleprev"),
      })
      )
      hl.bind(
      mod .. " + I",
      layout_bind({
        scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
        dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
        monocle = hl.dsp.layout("cyclenext"), -- Monocle and master: cycle prev window
        master = hl.dsp.layout("cyclenext"),
      })
      )

      hl.bind("mouse:275", hl.dsp.exec_cmd("uwsm-app -- toggle-mute"), { transparent = true, non_consuming = true })
      hl.bind(
      "SHIFT + mouse:275",
      hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"),
      { transparent = true, non_consuming = true }
      )
      hl.bind(mod .. " + M", hl.dsp.exec_cmd("uwsm-app -- toggle-mute"), { transparent = true, non_consuming = true })
      hl.bind(
      mods .. " + M",
      hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"),
      { transparent = true, non_consuming = true }
      )

      hl.bind(mod .. " + Q", hl.dsp.window.close())
      hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
      hl.bind("Pause", hl.dsp.exec_cmd(playerctl .. " play-pause"))
      hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
      hl.bind(mods .. " + T", hl.dsp.exec_cmd(term .. " --class tmux tmux"))
      hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
      hl.bind(mod .. " + E", hl.dsp.exec_cmd(files))
      hl.bind(mod .. " + grave", hl.dsp.exec_cmd(menu))
      hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
      hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind(mod .. " + Tab", hl.dsp.exec_cmd("rofi -show window -modi window"))
      hl.bind(mods .. " + U", function()
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class cava cava.sh",
        { workspace = "1 silent", float = true, size = { 888, 462 }, move = { 610, 609 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class btop btop.sh",
        { workspace = "1 silent", float = true, size = { 590, 637 }, move = { 10, 433 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class neo neo.sh",
        { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch",
        { workspace = "1 silent", float = true, size = { 590, 383 }, move = { 10, 42 } }
        ))
        hl.dispatch(hl.dsp.exec_cmd(
        "${cmd}",
        { workspace = "1 silent", float = true, size = { 888, 559 }, move = { 610, 42 } }
        ))
      end)
      hl.bind(mod .. " + Delete", hl.dsp.exec_cmd("rofi -show power-menu -modi power-menu:rofi-power-menu"))
      hl.bind("CTRL + SHIFT + L", hl.dsp.exec_cmd("uwsm-app -- swaylock -fF"))
      hl.bind(mod .. " + N", hl.dsp.exec_cmd("rofi -show Cliphist -modi Cliphist:cliphist.sh"))
      hl.bind(mod .. " + Apostrophe", hl.dsp.exec_cmd("rofi -show emoji nerdy -modi emoji,nerdy"))
      hl.bind(mod .. " + G", function()
        local gamemode = hl.get_config("animations.enabled")
        if gamemode == true then
          hl.config({
            general = {
              gaps_in = 0,
              gaps_out = 0,
              border_size = 1,
            },
            animations = {
              enabled = false,
            },
            decoration = {
              shadow = {
                enabled = false,
              },
              blur = {
                enabled = false,
              },
              rounding = 0,
              active_opacity = 1,
              inactive_opacity = 1,
              fullscreen_opacity = 1,
            },
          })
          hl.layer_rule({
            match = { namespace = "waybar" },
            blur = false,
            no_anim = true,
          })
          hl.layer_rule({
            match = { namespace = "rofi" },
            blur = false,
            ignore_alpha = 0,
            no_anim = true,
          })
          hl.layer_rule({
            match = { namespace = "notifications" },
            blur = false,
            ignore_alpha = 0,
            no_anim = true,
          })
          hl.window_rule({
            match = { class = "^(.*)$" }, opacity = "1.0 override 1.0 override 1.0 override"
          })
          hl.dispatch(hl.dsp.exec_cmd("pkill mpvpaper"))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
          hl.dispatch(hl.dsp.exec_cmd("${cmdGame}", { workspace = "1 silent", float = true, size = {1118, 710}, move = {401, 145} }))
        end
        if gamemode == false then
          hl.dispatch(hl.dsp.exec_cmd("uwsm app -- mpvpaper -f -p -o \"--loop hwdec=auto --no-audio\" '*' ${liveWallpaper.path}"))
          hl.dispatch(hl.dsp.exec_cmd("hyprctl reload config-only -q"))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
          hl.dispatch(hl.dsp.exec_cmd(
          "uwsm app -- kitty --class cava cava.sh",
          { workspace = "1 silent", float = true, size = { 888, 462 }, move = { 610, 609 } }
          ))
          hl.dispatch(hl.dsp.exec_cmd(
          "uwsm app -- kitty --class btop btop.sh",
          { workspace = "1 silent", float = true, size = { 590, 637 }, move = { 10, 433 } }
          ))
          hl.dispatch(hl.dsp.exec_cmd(
          "uwsm app -- kitty --class neo neo.sh",
          { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }
          ))
          hl.dispatch(hl.dsp.exec_cmd(
          "uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch",
          { workspace = "1 silent", float = true, size = { 590, 383 }, move = { 10, 42 } }
          ))
          hl.dispatch(hl.dsp.exec_cmd(
          "${cmd}",
          { workspace = "1 silent", float = true, size = { 888, 559 }, move = { 610, 42 } }
          ))
        end
      end)
      hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(term .. " --title btop btop"))
      hl.bind("XF86Calculator", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(mod .. " + Colon", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(moda .. " + S", hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mods .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))
      hl.bind("Print", hl.dsp.exec_cmd("hyprquickframe"))
      hl.bind(mod .. " + O", hl.dsp.exec_cmd("uwsm-app -- hyprpicker -a"))
      hl.bind(mods .. " + P", hl.dsp.submap("player"))
      hl.bind(mods .. " + Comma", hl.dsp.window.move({ monitor = "+1", follow = true }))
      hl.bind(mods .. " + Period", hl.dsp.window.move({ monitor = "-1", follow = true }))
      hl.bind(mod .. " + Comma", hl.dsp.focus({ monitor = "+1" }))
      hl.bind(mod .. " + Period", hl.dsp.focus({ monitor = "-1" }))

      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol dec"), { repeating = true, locked = true })
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol inc"), { repeating = true, locked = true })
      hl.bind(
      "SHIFT + XF86AudioLowerVolume",
      hl.dsp.exec_cmd(" uwsm-app -- playerVol dec-mini"),
      { repeating = true, locked = true }
      )
      hl.bind(
      "SHIFT + XF86AudioRaiseVolume",
      hl.dsp.exec_cmd(" uwsm-app -- playerVol inc-mini"),
      { repeating = true, locked = true }
      )
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(" uwsm-app -- brightness inc"), { repeating = true, locked = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(" uwsm-app -- brightness dec"), { repeating = true, locked = true })

      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(playerctl .. " play-pause"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd(playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("uwsm-app -- playerVol mute"), { locked = true })

      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      hl.define_submap("player", function()
      hl.bind("escape", hl.dsp.submap("reset"))
      hl.bind(mod .. " + P", hl.dsp.submap("reset"))
      hl.bind("O", hl.dsp.exec_cmd("uwsm-app -- playerVol inc"), { repeating = true, locked = true })
      hl.bind("I", hl.dsp.exec_cmd("uwsm-app -- playerVol dec"), { repeating = true, locked = true })
      hl.bind("SHIFT + O", hl.dsp.exec_cmd(playerctl .. " next"), { repeating = true, locked = true })
      hl.bind("SHIFT + I", hl.dsp.exec_cmd(playerctl .. " previous"), { repeating = true, locked = true })
      hl.bind("P", hl.dsp.exec_cmd(playerctl .. " play-pause"), { locked = true })
      end)

      -- hl.bind(mod .. " + I", hl.dsp.easymotion({ action = "hyprctl dispatch focuswindow", address = {} }))
      -- hl.config({
      --   plugin = {
      --     easymotion = {
      --       textcolor = "rgba(59f8fdff)",
      --       bgcolor = "rgba(0a1e23bb)",
      --       bordercolor = {colors = { "rgb(27a195)", "rgb(de51f6)", "rgb(dbf5ff)" }, angle = 40 },
      --       blur = 1,
      --       textpadding = 8,
      --       textsize = 35,
      --       bordersize = 2,
      --       fullscreen_action = "maximize"
      --     }
      --   }
      -- })

      hl.bind(
      mod .. " + R",
      layout_bind({
        scrolling = hl.dsp.layout("colresize 0.5"),
      })
      )
      hl.bind(
      mod .. " + H",
      layout_bind({
        scrolling = hl.dsp.layout("move -col"),
        dwindle = hl.dsp.focus({ direction = "left" }),
        monocle = hl.dsp.focus({ direction = "left" }),
        master = hl.dsp.focus({ direction = "left" }),
      })
      )
      hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
      hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
      hl.bind(
      mod .. " + L",
      layout_bind({
        scrolling = hl.dsp.layout("move +col"),
        dwindle = hl.dsp.focus({ direction = "right" }),
        monocle = hl.dsp.focus({ direction = "right" }),
        master = hl.dsp.focus({ direction = "right" }),
      })
      )
      hl.bind(
      mod .. " + Left",
      layout_bind({
        scrolling = hl.dsp.layout("move -col"),
        dwindle = hl.dsp.focus({ direction = "left" }),
        monocle = hl.dsp.focus({ direction = "left" }),
        master = hl.dsp.focus({ direction = "left" }),
      })
      )
      hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
      hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
      hl.bind(
      mod .. " + Right",
      layout_bind({
        scrolling = hl.dsp.layout("move +col"),
        dwindle = hl.dsp.focus({ direction = "right" }),
        monocle = hl.dsp.focus({ direction = "right" }),
        master = hl.dsp.focus({ direction = "right" }),
      })
      )
      hl.bind(mods .. " + H", hl.dsp.focus({ workspace = "r-1" }))
      hl.bind(mods .. " + L", hl.dsp.focus({ workspace = "r+1" }))
      hl.bind(mods .. " + J", hl.dsp.focus({ workspace = "empty" }))
      hl.bind(mods .. " + Left", hl.dsp.focus({ workspace = "r-1" }))
      hl.bind(mods .. " + Right", hl.dsp.focus({ workspace = "r+1" }))
      hl.bind(mods .. " + Down", hl.dsp.focus({ workspace = "empty" }))
      hl.bind(
      mod .. " + mouse_up",
      layout_bind({
        scrolling = hl.dsp.layout("focus left"),
        dwindle = hl.dsp.focus({ workspace = "e-1" }),
        monocle = hl.dsp.focus({ workspace = "e-1" }),
        master = hl.dsp.focus({ workspace = "e-1" }),
      })
      )
      hl.bind(
      mod .. " + mouse_down",
      layout_bind({
        scrolling = hl.dsp.layout("focus right"),
        dwindle = hl.dsp.focus({ workspace = "e+1" }),
        monocle = hl.dsp.focus({ workspace = "e+1" }),
        master = hl.dsp.focus({ workspace = "e+1" }),
      })
      )
      hl.bind(
      mods .. " + mouse_up",
      layout_bind({
        scrolling = hl.dsp.focus({ workspace = "e-1" }),
      })
      )
      hl.bind(
      mods .. " + mouse_down",
      layout_bind({
        scrolling = hl.dsp.focus({ workspace = "e+1" }),
      })
      )
      hl.bind(modc .. " + H", hl.dsp.group.prev())
      hl.bind(modc .. " + L", hl.dsp.group.next())
      hl.bind(modc .. " + Left", hl.dsp.group.prev())
      hl.bind(modc .. " + Right", hl.dsp.group.next())
      hl.bind(mod .. " + Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind(
      mod .. " + C",
      layout_bind({
        scrolling = hl.dsp.layout("colresize +conf"),
      })
      )
      hl.bind(
      mods .. " + C",
      layout_bind({
        scrolling = hl.dsp.layout("colresize -conf"),
      })
      )

      hl.bind(mod .. " + A", hl.dsp.submap("manage"))
      hl.define_submap("manage", function()
      hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
      hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("W", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(
        "P",
        layout_bind({
                scrolling = hl.dsp.layout("promote"),
        })
      )
      hl.bind("O", hl.dsp.window.pin())
      hl.bind("Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind(
        "H",
        layout_bind({
                scrolling = hl.dsp.layout("move -col"),
                dwindle = hl.dsp.focus({ direction = "left" }),
                monocle = hl.dsp.focus({ direction = "left" }),
                master = hl.dsp.focus({ direction = "left" }),
        })
      )
      hl.bind("J", hl.dsp.focus({ direction = "down" }))
      hl.bind("K", hl.dsp.focus({ direction = "up" }))
      hl.bind(
        "L",
        layout_bind({
                scrolling = hl.dsp.layout("move +col"),
                dwindle = hl.dsp.focus({ direction = "right" }),
                monocle = hl.dsp.focus({ direction = "right" }),
                master = hl.dsp.focus({ direction = "right" }),
        })
      )
      hl.bind(
        "Left",
        layout_bind({
                scrolling = hl.dsp.layout("move -col"),
                dwindle = hl.dsp.focus({ direction = "left" }),
                monocle = hl.dsp.focus({ direction = "left" }),
                master = hl.dsp.focus({ direction = "left" }),
        })
      )
      hl.bind("Down", hl.dsp.focus({ direction = "down" }))
      hl.bind("Up", hl.dsp.focus({ direction = "up" }))
      hl.bind(
        "Right",
        layout_bind({
                scrolling = hl.dsp.layout("move +col"),
                dwindle = hl.dsp.focus({ direction = "right" }),
                monocle = hl.dsp.focus({ direction = "right" }),
                master = hl.dsp.focus({ direction = "right" }),
        })
      )
      hl.bind(
        mod .. " + C",
        layout_bind({
                scrolling = hl.dsp.layout("colresize +conf"),
        })
      )
      hl.bind(
        mods .. " + C",
        layout_bind({
                scrolling = hl.dsp.layout("colresize -conf"),
        })
      )
      hl.bind("R", hl.dsp.layout("colresize 0.5"))
      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      hl.bind(mods .. " + H", hl.dsp.window.move({ workspace = "r-1" }))
      hl.bind(mods .. " + L", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(mods .. " + J", hl.dsp.window.move({ workspace = "empty" }))
      hl.bind(mods .. " + Left", hl.dsp.window.move({ workspace = "r-1" }))
      hl.bind(mods .. " + Right", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(mods .. " + Down", hl.dsp.window.move({ workspace = "empty" }))

      hl.bind("CTRL + H", hl.dsp.group.prev())
      hl.bind("CTRL + L", hl.dsp.group.next())
      hl.bind("CTRL + Left", hl.dsp.group.prev())
      hl.bind("CTRL + Right", hl.dsp.group.next())

      hl.bind(mod .. " + H", hl.dsp.window.move({ direction = "left" }))
      hl.bind(mod .. " + J", hl.dsp.window.move({ direction = "down" }))
      hl.bind(mod .. " + K", hl.dsp.window.move({ direction = "up" }))
      hl.bind(mod .. " + L", hl.dsp.window.move({ direction = "right" }))
      hl.bind(mod .. " + Left", hl.dsp.window.move({ direction = "left" }))
      hl.bind(mod .. " + Down", hl.dsp.window.move({ direction = "down" }))
      hl.bind(mod .. " + Up", hl.dsp.window.move({ direction = "up" }))
      hl.bind(mod .. " + Right", hl.dsp.window.move({ direction = "right" }))

      hl.bind(modc .. " + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(modc .. " + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(modc .. " + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(modc .. " + L", hl.dsp.window.move({ direction = "right", group_aware = true }))
      hl.bind(modc .. " + Left", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(modc .. " + Down", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(modc .. " + Up", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(modc .. " + Right", hl.dsp.window.move({ direction = "right", group_aware = true }))

      hl.bind(
        mod .. " + U",
        layout_bind({
                scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
                dwindle = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
                monocle = hl.dsp.layout("cycleprev"), -- Monocle and master: cycle prev window
                master = hl.dsp.layout("cycleprev"),
        })
      )
      hl.bind(
        mod .. " + I",
        layout_bind({
                scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
                dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
                monocle = hl.dsp.layout("cyclenext"), -- Monocle and master: cycle prev window
                master = hl.dsp.layout("cyclenext"),
        })
      )
      hl.bind(
        mod .. " + mouse_up",
        layout_bind({
                scrolling = hl.dsp.layout("focus left"),
                dwindle = hl.dsp.focus({ workspace = "e-1" }),
                monocle = hl.dsp.focus({ workspace = "e-1" }),
                master = hl.dsp.focus({ workspace = "e-1" }),
        })
      )
      hl.bind(
        mod .. " + mouse_down",
        layout_bind({
                scrolling = hl.dsp.layout("focus right"),
                dwindle = hl.dsp.focus({ workspace = "e+1" }),
                monocle = hl.dsp.focus({ workspace = "e+1" }),
                master = hl.dsp.focus({ workspace = "e+1" }),
        })
      )
      hl.bind(
        mods .. " + mouse_up",
        layout_bind({
                scrolling = hl.dsp.focus({ workspace = "e-1" }),
        })
      )
      hl.bind(
        mods .. " + mouse_down",
        layout_bind({
                scrolling = hl.dsp.focus({ workspace = "e+1" }),
        })
      )

      hl.bind(mod .. " + R", hl.dsp.submap("resizeTiled"))
      hl.define_submap("resizeTiled", function()
        hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
        hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
        hl.bind("Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
        hl.bind(
                mod .. " + C",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize +conf"),
                })
        )
        hl.bind(
                mods .. " + C",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize -conf"),
                })
        )
        hl.bind("W", hl.dsp.window.float({ action = "toggle" }))
        hl.bind(
                "R",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize 0.5"),
                })
        )
        hl.bind(
                "Left",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize -0.1"),
                        { repeating = true },
                        dwindle = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                        monocle = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                        master = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                })
        )
        hl.bind("Down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))
        hl.bind("Up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
        hl.bind(
                "Right",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize +0.1"),
                        { repeating = true },
                        dwindle = hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
                        { repeating = true },
                        monocle = hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
                        { repeating = true },
                        master = hl.dsp.window.resize({ x = 10, y = 0, relative = true }),
                        { repeating = true },
                })
        )
        hl.bind(
                "H",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize -0.1"),
                        { repeating = true },
                        dwindle = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                        monocle = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                        master = hl.dsp.window.resize({ x = -10, y = 0, relative = true }),
                        { repeating = true },
                })
        )
        hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))
        hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
        hl.bind(
                "L",
                layout_bind({
                        scrolling = hl.dsp.layout("colresize +0.1"),
                        { repeating = true },
                        dwindle = hl.dsp.window.resize({ x = "+10", y = 0, relative = true }),
                        { repeating = true },
                        monocle = hl.dsp.window.resize({ x = "+10", y = 0, relative = true }),
                        { repeating = true },
                        master = hl.dsp.window.resize({ x = "+10", y = 0, relative = true }),
                        { repeating = true },
                })
        )
        hl.bind(mod .. " + R", hl.dsp.submap("manage"))
        hl.bind(mods .. " + R", hl.dsp.submap("resize"))
        hl.bind("escape", hl.dsp.submap("manage"))
      end)

      -- hl.bind(mods .." + R", hl.dsp.submap("resize"))
      -- hl.define_submap("resize", function()
      --   hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
      --   hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
      --   hl.bind("Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
      -- hl.bind(
      -- 	mod .. " + C",
      -- 	layout_bind({
      -- 		scrolling = hl.dsp.layout("colresize +conf"),
      -- 		dwindle = "",
      -- 		monocle = "",
      -- 		master = "",
      -- 	})
      -- )
      -- hl.bind(
      -- 	mods .. " + C",
      -- 	layout_bind({
      -- 		scrolling = hl.dsp.layout("colresize -conf"),
      -- 		dwindle = "",
      -- 		monocle = "",
      -- 		master = "",
      -- 	})
      -- )
      --   hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
      --   hl.bind("R", hl.dsp.layout("colresize 0.5")),
      --   binde = , Right, resizeactive, 30 0
      --   binde = , Left, resizeactive, 30 0
      --   binde = , Left, moveactive, -30 0
      --   binde = , Up, resizeactive, 0 30
      --   binde = , Up, moveactive, 0 -30
      --   binde = , Down, resizeactive, 0 30
      --
      --   binde = , L, resizeactive, 30 0
      --   binde = , H, resizeactive, 30 0
      --   binde = , H, moveactive, -30 0
      --   binde = , K, resizeactive, 0 30
      --   binde = , K, moveactive, 0 -30
      --   binde = , J, resizeactive, 0 30
      --
      --   binde = SHIFT, Right, resizeactive, -30 0
      --   binde = SHIFT, Right, moveactive, 30 0
      --   binde = SHIFT, Left, resizeactive, -30 0
      --   binde = SHIFT, Up, resizeactive, 0 -30
      --   binde = SHIFT, Down, resizeactive, 0 -30
      --   binde = SHIFT, Down, moveactive, 0 30
      --
      --   binde = SHIFT, L, resizeactive, -30 0
      --   binde = SHIFT, L, moveactive, 30 0
      --   binde = SHIFT, H, resizeactive, -30 0
      --   binde = SHIFT, K, resizeactive, 0 -30
      --   binde = SHIFT, J, resizeactive, 0 -30
      --   binde = SHIFT, J, moveactive, 0 30
      --   bind = $mods, R, submap, manage
      --   bind = $mod, R, submap, resizeTiled
      --   bind = , escape, submap, manage
      -- end)

      -- bind = , M, submap, move
      --   submap = move
      --   hl.bind("ALT + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
      --   hl.bind("ALT + SHIFT + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
      --   hl.bind("Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
      -- hl.bind(
      -- 	mod .. " + C",
      -- 	layout_bind({
      -- 		scrolling = hl.dsp.layout("colresize +conf"),
      -- 		dwindle = "",
      -- 		monocle = "",
      -- 		master = "",
      -- 	})
      -- )
      -- hl.bind(
      -- 	mods .. " + C",
      -- 	layout_bind({
      -- 		scrolling = hl.dsp.layout("colresize -conf"),
      -- 		dwindle = "",
      -- 		monocle = "",
      -- 		master = "",
      -- 	})
      -- )
      --   hl.bind("W", hl.dsp.window.float({ action = "toggle" })),
      --   hl.bind("R", hl.dsp.layout("colresize 0.5")),
      --   binde = , Left, moveactive, 10 0
      --   binde = , Right, moveactive, -10 0
      --   binde = , Up, moveactive, 0 -10
      --   binde = , Down, moveactive, 0 10
      --   binde = , H, moveactive, 30 0
      --   binde = , L, moveactive, -30 0
      --   binde = , K, moveactive, 0 -30
      --   binde = , J, moveactive, 0 30
      --   bind = , M, submap, manage
      --   bind = , escape, submap, manage

      hl.bind("Escape", hl.dsp.submap("reset"))

      hl.bind(mod .. " + A", hl.dsp.submap("reset"))
      end)
    '';
}
