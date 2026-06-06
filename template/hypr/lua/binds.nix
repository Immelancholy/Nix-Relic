{ config, ... }:
let
  inherit (config.player) cmd class cmdGame;
  inherit (config.wayland.windowManager.hyprland) liveWallpaper;
  wallpaperKill = "${
    if liveWallpaper.enable then
      ''
        hl.exec_cmd("systemctl start --user hyprpaper")
            hl.exec_cmd("pkill mpvpaper")
      ''
    else
      ""
  }";
in
{
  xdg.configFile."hypr/lua/binds.lua".text = /* Lua */ ''
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

    local function universal_binds()
      for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(Mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(Mods .. " + " .. key, hl.dsp.window.move({ workspace = i }))
        hl.bind(Modc .. " + " .. key, hl.dsp.group.active({ index = i }))
      end

      local MAX_ZOOM = 3
      local MIN_ZOOM = 1
      local ZOOM_TOGGLE_FACTOR = 1.5

      ---@param offset number
      ---@return nil
      local function zoom(offset)
        local current = hl.get_config("cursor.zoom_factor")
        if offset ~= nil then
          current = current + offset
        elseif current ~= MIN_ZOOM then
          current = MIN_ZOOM
        else
          current = ZOOM_TOGGLE_FACTOR
        end
        current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
        hl.config({ cursor = { zoom_factor = current } })
      end

      hl.bind("SUPER + Z", zoom)
      hl.bind("SUPER + equal", function()
        zoom(0.5)
      end)
      hl.bind("SUPER + minus", function()
        zoom(-0.5)
      end)

      hl.bind(Mod .. " + F9", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(Mod .. " + F10", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(Mod .. " + F12", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(Moda .. " + V", hl.dsp.workspace.toggle_special("video"))
      hl.bind(Moda .. " + G", hl.dsp.workspace.toggle_special("game"))
      hl.bind(Moda .. " + W", hl.dsp.workspace.toggle_special("win"))
      hl.bind(Mods .. " + G", hl.dsp.window.move({ workspace = "special:game" }))
      hl.bind(Mods .. " + V", hl.dsp.window.move({ workspace = "special:video" }))
      hl.bind(Mods .. " + W", hl.dsp.window.move({ workspace = "special:win" }))

      hl.bind(
        Mod .. " + U",
        layout_bind({
          scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
          dwindle = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
          master = hl.dsp.layout("cycleprev"),
          monocle = hl.dsp.layout("cycleprev"), -- Monocle and master: cycle prev window
        })
      )
      hl.bind(
        Mod .. " + I",
        layout_bind({
          scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
          dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
          master = hl.dsp.layout("cyclenext"),
          monocle = hl.dsp.layout("cyclenext"), -- Monocle and master: cycle prev window
        })
      )

      hl.bind(
        Mod .. " + Space",
        layout_bind({
          scrolling = function()
            local centred = hl.get_config("scrolling.focus_fit_method")
            local wrap = hl.get_config("scrolling.wrap_swapcol")
            if centred == 1 then
              hl.config({
                scrolling = {
                  focus_fit_method = 0,
                },
              })
            else
              hl.config({
                scrolling = {
                  focus_fit_method = 1,
                },
              })
            end
            if wrap == false then
              hl.config({
                scrolling = {
                  wrap_swapcol = true,
                },
              })
            end
            hl.dispatch(hl.dsp.layout("swapcol l"))
            hl.dispatch(hl.dsp.layout("swapcol r"))
            hl.config({
              scrolling = {
                wrap_swapcol = wrap,
              },
            })
          end,
        })
      )

      hl.bind("mouse:275", hl.dsp.exec_cmd("uwsm-app -- toggle-mute"), { transparent = true, non_consuming = true })
      hl.bind(
        "SHIFT + mouse:275",
        hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"),
        { transparent = true, non_consuming = true }
      )
      hl.bind(Modc .. " + M", hl.dsp.exec_cmd("uwsm-app -- toggle-mute"), { transparent = true, non_consuming = true })
      hl.bind(
        Modc .. " + SHIFT + M",
        hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"),
        { transparent = true, non_consuming = true }
      )
      hl.bind(Mod .. " + Q", hl.dsp.window.close())
      hl.bind(Mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(Mod .. " + D", hl.dsp.focus({ window = "floating" }))
      hl.bind(Mod .. " + S", hl.dsp.focus({ window = "tiled" }))
      hl.bind("Pause", hl.dsp.exec_cmd(Playerctl .. " play-pause"))
      hl.bind(Mod .. " + T", hl.dsp.exec_cmd(Term))
      hl.bind(Mods .. " + T", hl.dsp.exec_cmd(Term .. " --class tmux tmux"))
      hl.bind(Mod .. " + F", hl.dsp.exec_cmd(Browser))
      hl.bind(Mod .. " + E", hl.dsp.exec_cmd(Files))
      hl.bind(Mod .. " + grave", hl.dsp.exec_cmd(Menu))
      hl.bind(Mod .. " + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
      hl.bind(Mods .. " + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("ALT + Tab", hl.dsp.exec_cmd("rofi -show window -Modi window"))

      hl.bind(Mod .. " + Tab", function()
        local layouts = { "scrolling", "dwindle", "master", "monocle" }
        local workspace = hl.get_active_workspace()
        local next_layout = "dwindle"

        if not workspace then
          return
        end

        for i = 1, #layouts do
          if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
          end
        end

        hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
      end)

      hl.bind(Mods .. " + Tab", function()
        local layouts = { "monocole", "master", "dwindle", "scrolling" }
        local workspace = hl.get_active_workspace()
        local next_layout = "dwindle"

        if not workspace then
          return
        end

        for i = 1, #layouts do
          if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
          end
        end

        hl.workspace_rule({ workspace = workspace.name, layout = next_layout })
      end)

      hl.bind(Mods .. " + U", function()
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
        hl.dispatch(
          hl.dsp.exec_cmd(
            "uwsm-app -- kitty --class cava relic-cava",
            { workspace = "1 silent", float = true, size = { 888, 462 }, move = { 610, 609 } }
          )
        )
        hl.dispatch(
          hl.dsp.exec_cmd(
            "uwsm-app -- kitty --class btop relic-btop",
            { workspace = "1 silent", float = true, size = { 590, 637 }, move = { 10, 433 } }
          )
        )
        hl.dispatch(
          hl.dsp.exec_cmd(
            "uwsm-app -- kitty --class neo relic-neo",
            { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }
          )
        )
        hl.dispatch(
          hl.dsp.exec_cmd(
            "uwsm-app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch",
            { workspace = "1 silent", float = true, size = { 590, 383 }, move = { 10, 42 } }
          )
        )
        hl.dispatch(
          hl.dsp.exec_cmd(
            "${cmd}",
            { workspace = "1 silent", float = true, size = { 888, 559 }, move = { 610, 42 } }
          )
        )
      end)

      hl.bind(Mod .. " + Delete", hl.dsp.exec_cmd("rofi -show power-menu -modi power-menu:rofi-power-menu"))
      hl.bind("CTRL + SHIFT + L", hl.dsp.exec_cmd("uwsm-app -- swaylock -fF"))
      hl.bind(Mod .. " + N", hl.dsp.exec_cmd("rofi -show Cliphist -modi Cliphist:rofi-cliphist"))
      hl.bind(Mod .. " + Apostrophe", hl.dsp.exec_cmd("rofi -show emoji nerdy -modi emoji,nerdy"))

      hl.bind(Mod .. " + G", function()
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
              screen_shader = "",
              shadow = {
                enabled = false,
              },
              blur = {
                enabled = false,
              },
              motion_blur = {
                enabled = false,
              },
              glow = {
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
            match = { class = "^(.*)$" },
            opacity = "1.0 override 1.0 override 1.0 override",
          })
          ${wallpaperKill}
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(${class})$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(neo)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(fastfetch)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(btop)$" }))
          hl.dispatch(hl.dsp.window.kill({ window = "class:^(cava)$" }))
          hl.dispatch(
            hl.dsp.exec_cmd(
              "${cmdGame}",
              { workspace = "1 silent", float = true, size = { 1118, 710 }, move = { 401, 145 } }
            )
          )
        end
        if gamemode == false then
          hl.dispatch(hl.dsp.exec_cmd("hyprctl reload config-only -q"))
        end
      end)

      hl.bind(Mod .. " + Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(Term .. " --title btop btop"))
      hl.bind("XF86Calculator", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(Mod .. " + semicolon", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(Moda .. " + S", hl.dsp.workspace.toggle_special("magic"))
      hl.bind(Mods .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))
      hl.bind("Print", hl.dsp.exec_cmd("hyprquickframe -n -d"))
      hl.bind(Mod .. " + O", hl.dsp.exec_cmd("uwsm-app -- hyprpicker -a"))
      hl.bind(Mods .. " + P", hl.dsp.submap("player"))
      hl.bind(Mods .. " + Comma", hl.dsp.window.move({ monitor = "+1", follow = true }))
      hl.bind(Mods .. " + Period", hl.dsp.window.move({ monitor = "-1", follow = true }))
      hl.bind(Mod .. " + Comma", hl.dsp.focus({ monitor = "+1" }))
      hl.bind(Mod .. " + Period", hl.dsp.focus({ monitor = "-1" }))
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

      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(Playerctl .. " play-pause"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd(Playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(Playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("uwsm-app -- playerVol mute"), { locked = true })

      hl.bind(Mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(Mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
      hl.bind(
        Mod .. " + C",
        layout_bind({
          scrolling = hl.dsp.layout("colresize +conf"),
        })
      )
      hl.bind(
        Mods .. " + C",
        layout_bind({
          scrolling = hl.dsp.layout("colresize -conf"),
        })
      )
      hl.bind(
        Mod .. " + X",
        layout_bind({
          scrolling = hl.dsp.layout("colresize 0.5"),
        })
      )
      hl.bind(
        Mod .. " + mouse_up",
        layout_bind({
          scrolling = hl.dsp.layout("focus left"),
        })
      )
      hl.bind(
        Mod .. " + mouse_down",
        layout_bind({
          scrolling = hl.dsp.layout("focus right"),
        })
      )
      hl.bind(
        Mods .. " + mouse_up",
        layout_bind({
          scrolling = hl.dsp.focus({ workspace = "e-1" }),
          dwindle = hl.dsp.focus({ workspace = "e-1" }),
          master = hl.dsp.focus({ workspace = "e-1" }),
          monocle = hl.dsp.focus({ workspace = "e-1" }),
        })
      )
      hl.bind(
        Mods .. " + mouse_down",
        layout_bind({
          scrolling = hl.dsp.focus({ workspace = "e+1" }),
          dwindle = hl.dsp.focus({ workspace = "e+1" }),
          master = hl.dsp.focus({ workspace = "e+1" }),
          monocle = hl.dsp.focus({ workspace = "e+1" }),
        })
      )
      hl.bind(Modc .. " + G", hl.dsp.group.toggle())
      Universal_User_Binds()
    end
    universal_binds()

    hl.bind(Modc .. " + H", hl.dsp.group.prev())
    hl.bind(Modc .. " + L", hl.dsp.group.next())
    hl.bind(Modc .. " + Left", hl.dsp.group.prev())
    hl.bind(Modc .. " + Right", hl.dsp.group.next())
    hl.bind(
      Mod .. " + H",
      layout_bind({
        scrolling = hl.dsp.layout("move -col"),
        dwindle = hl.dsp.focus({ direction = "left" }),
        master = hl.dsp.focus({ direction = "left" }),
        monocle = hl.dsp.focus({ direction = "left" }),
      })
    )
    hl.bind(Mod .. " + J", hl.dsp.focus({ direction = "down" }))
    hl.bind(Mod .. " + K", hl.dsp.focus({ direction = "up" }))
    hl.bind(
      Mod .. " + L",
      layout_bind({
        scrolling = hl.dsp.layout("move +col"),
        dwindle = hl.dsp.focus({ direction = "right" }),
        master = hl.dsp.focus({ direction = "right" }),
        monocle = hl.dsp.focus({ direction = "right" }),
      })
    )
    hl.bind(
      Mod .. " + Left",
      layout_bind({
        scrolling = hl.dsp.layout("move -col"),
        dwindle = hl.dsp.focus({ direction = "left" }),
        master = hl.dsp.focus({ direction = "left" }),
        monocle = hl.dsp.focus({ direction = "left" }),
      })
    )
    hl.bind(Mod .. " + Down", hl.dsp.focus({ direction = "down" }))
    hl.bind(Mod .. " + Up", hl.dsp.focus({ direction = "up" }))
    hl.bind(
      Mod .. " + Right",
      layout_bind({
        scrolling = hl.dsp.layout("move +col"),
        dwindle = hl.dsp.focus({ direction = "right" }),
        master = hl.dsp.focus({ direction = "right" }),
        monocle = hl.dsp.focus({ direction = "right" }),
      })
    )
    hl.bind(Mods .. " + H", hl.dsp.focus({ workspace = "r-1" }))
    hl.bind(Mods .. " + L", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind(Mods .. " + J", hl.dsp.focus({ workspace = "empty" }))
    hl.bind(Mods .. " + Left", hl.dsp.focus({ workspace = "r-1" }))
    hl.bind(Mods .. " + Right", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind(Mods .. " + Down", hl.dsp.focus({ workspace = "empty" }))

    hl.bind(Mod .. " + A", hl.dsp.submap("manage"))
    hl.define_submap("manage", function()
      universal_binds()
      hl.bind(Mod .. " + P", hl.dsp.window.pin())

      hl.bind(
        "H",
        layout_bind({
          scrolling = hl.dsp.layout("move -col"),
          dwindle = hl.dsp.focus({ direction = "left" }),
          master = hl.dsp.focus({ direction = "left" }),
          monocle = hl.dsp.focus({ direction = "left" }),
        })
      )
      hl.bind("J", hl.dsp.focus({ direction = "down" }))
      hl.bind("K", hl.dsp.focus({ direction = "up" }))
      hl.bind(
        "L",
        layout_bind({
          scrolling = hl.dsp.layout("move +col"),
          dwindle = hl.dsp.focus({ direction = "right" }),
          master = hl.dsp.focus({ direction = "right" }),
          monocle = hl.dsp.focus({ direction = "right" }),
        })
      )
      hl.bind(
        "Left",
        layout_bind({
          scrolling = hl.dsp.layout("move -col"),
          dwindle = hl.dsp.focus({ direction = "left" }),
          master = hl.dsp.focus({ direction = "left" }),
          monocle = hl.dsp.focus({ direction = "left" }),
        })
      )
      hl.bind("Down", hl.dsp.focus({ direction = "down" }))
      hl.bind("Up", hl.dsp.focus({ direction = "up" }))
      hl.bind(
        "Right",
        layout_bind({
          scrolling = hl.dsp.layout("move +col"),
          dwindle = hl.dsp.focus({ direction = "right" }),
          master = hl.dsp.focus({ direction = "right" }),
          monocle = hl.dsp.focus({ direction = "right" }),
        })
      )

      hl.bind(Mods .. " + H", hl.dsp.window.move({ workspace = "r-1" }))
      hl.bind(Mods .. " + L", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(Mods .. " + J", hl.dsp.window.move({ workspace = "empty" }))
      hl.bind(Mods .. " + Left", hl.dsp.window.move({ workspace = "r-1" }))
      hl.bind(Mods .. " + Right", hl.dsp.window.move({ workspace = "r+1" }))
      hl.bind(Mods .. " + Down", hl.dsp.window.move({ workspace = "empty" }))

      hl.bind("CTRL + H", hl.dsp.group.prev())
      hl.bind("CTRL + L", hl.dsp.group.next())
      hl.bind("CTRL + Left", hl.dsp.group.prev())
      hl.bind("CTRL + Right", hl.dsp.group.next())

      hl.bind(
        Mod .. " + H",
        layout_bind({
          scrolling = hl.dsp.layout("consume_or_expel prev"),
          dwindle = hl.dsp.window.move({ direction = "left" }),
          master = hl.dsp.window.move({ direction = "left" }),
          monocle = hl.dsp.window.move({ direction = "left" }),
        })
      )
      hl.bind(Mod .. " + J", hl.dsp.window.move({ direction = "down" }))
      hl.bind(Mod .. " + K", hl.dsp.window.move({ direction = "up" }))
      hl.bind(
        Mod .. " + L",
        layout_bind({
          scrolling = hl.dsp.layout("consume_or_expel next"),
          dwindle = hl.dsp.window.move({ direction = "right" }),
          master = hl.dsp.window.move({ direction = "right" }),
          monocle = hl.dsp.window.move({ direction = "right" }),
        })
      )

      hl.bind(
        Mod .. " + Left",
        layout_bind({
          scrolling = hl.dsp.layout("consume_or_expel prev"),
          dwindle = hl.dsp.window.move({ direction = "left" }),
          master = hl.dsp.window.move({ direction = "left" }),
          monocle = hl.dsp.window.move({ direction = "left" }),
        })
      )
      hl.bind(Mod .. " + Down", hl.dsp.window.move({ direction = "down" }))
      hl.bind(Mod .. " + Up", hl.dsp.window.move({ direction = "up" }))
      hl.bind(
        Mod .. " + Right",
        layout_bind({
          scrolling = hl.dsp.layout("consume_or_expel next"),
          dwindle = hl.dsp.window.move({ direction = "right" }),
          master = hl.dsp.window.move({ direction = "right" }),
          monocle = hl.dsp.window.move({ direction = "right" }),
        })
      )

      hl.bind(Modc .. " + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(Modc .. " + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(Modc .. " + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(Modc .. " + L", hl.dsp.window.move({ direction = "right", group_aware = true }))
      hl.bind(Modc .. " + Left", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(Modc .. " + Down", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(Modc .. " + Up", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(Modc .. " + Right", hl.dsp.window.move({ direction = "right", group_aware = true }))

      hl.bind(Mod .. " + R", hl.dsp.submap("resize"))
      hl.define_submap("resize", function()
        universal_binds()

        hl.bind(Mod .. " + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

        hl.bind(Mod .. " + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
        hl.bind(Mod .. " + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

        hl.bind(Mod .. " + M", hl.dsp.submap("move"))
        hl.bind(Mod .. " + R", hl.dsp.submap("manage"))
        hl.bind(Mod .. " + A", hl.dsp.submap("manage"))
        hl.bind("escape", hl.dsp.submap("manage"))
        Resize_User_Binds()
      end)

      hl.bind(Mod .. " + M", hl.dsp.submap("move"))
      hl.define_submap("move", function()
        universal_binds()

        hl.bind(Mod .. " + Left", hl.dsp.window.move({ x = -10, y = 0, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Down", hl.dsp.window.move({ x = 0, y = 10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Up", hl.dsp.window.move({ x = 0, y = -10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + Right", hl.dsp.window.move({ x = 10, y = 0, relative = true }), { repeating = true })

        hl.bind(Mod .. " + H", hl.dsp.window.move({ x = -10, y = 0, relative = true }), { repeating = true })
        hl.bind(Mod .. " + J", hl.dsp.window.move({ x = 0, y = 10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + K", hl.dsp.window.move({ x = 0, y = -10, relative = true }), { repeating = true })
        hl.bind(Mod .. " + L", hl.dsp.window.move({ x = 10, y = 0, relative = true }), { repeating = true })

        hl.bind(Mod .. " + R", hl.dsp.submap("resize"))
        hl.bind(Mod .. " + M", hl.dsp.submap("manage"))
        hl.bind(Mod .. " + A", hl.dsp.submap("manage"))
        hl.bind("escape", hl.dsp.submap("manage"))
        Move_User_Binds()
      end)

      hl.bind("Escape", hl.dsp.submap("reset"))

      hl.bind(Mod .. " + A", hl.dsp.submap("reset"))
      Manage_User_Binds()
    end)

    hl.define_submap("player", function()
      universal_binds()
      hl.bind("escape", hl.dsp.submap("reset"))
      hl.bind(Mods .. " + P", hl.dsp.submap("reset"))
      hl.bind("O", hl.dsp.exec_cmd("uwsm-app -- playerVol inc"), { repeating = true, locked = true })
      hl.bind("I", hl.dsp.exec_cmd("uwsm-app -- playerVol dec"), { repeating = true, locked = true })
      hl.bind("SHIFT + O", hl.dsp.exec_cmd(Playerctl .. " next"), { repeating = true, locked = true })
      hl.bind("SHIFT + I", hl.dsp.exec_cmd(Playerctl .. " previous"), { repeating = true, locked = true })
      hl.bind("P", hl.dsp.exec_cmd(Playerctl .. " play-pause"), { locked = true })
      Player_User_Binds()
    end)
    Default_User_Binds()
  '';
}
