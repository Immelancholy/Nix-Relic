{ config, ... }:
let
  inherit (config.player) cmd class cmdGame;
  inherit (config.wayland.windowManager.hyprland) liveWallpaper;
in
{
  xdg.configFile."hypr/lua/binds.lua".text = /* Lua */ ''
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

    local function universal_binds()
      for i = 1, 10 do
      local key = i % 10 -- 10 maps to key 0
        hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
        hl.bind(mods .. " + " .. key, hl.dsp.window.move({ workspace = i }))
        hl.bind(modc .. " + " .. key, hl.dsp.group.active({ index = i }))
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

      hl.bind(mod .. " + F9", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(mod .. " + F10", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(mod .. " + F12", hl.dsp.pass({ window = "class:^(com.obsproject.studio)$" }))
      hl.bind(moda .. " + V", hl.dsp.workspace.toggle_special("video"))
      hl.bind(moda .. " + G", hl.dsp.workspace.toggle_special("game"))
      hl.bind(moda .. " + W", hl.dsp.workspace.toggle_special("win"))
      hl.bind(mods .. " + G", hl.dsp.window.move({ workspace = "special:game" }))
      hl.bind(mods .. " + V", hl.dsp.window.move({ workspace = "special:video" }))
      hl.bind(mods .. " + W", hl.dsp.window.move({ workspace = "special:win" }))

      hl.bind(
      mod .. " + U",
      layout_bind({
        scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
        dwindle = hl.dsp.layout("swapsplit"), -- Dwindle: swap window split
        master = hl.dsp.layout("cycleprev"),
        monocle = hl.dsp.layout("cycleprev"), -- Monocle and master: cycle prev window
      })
      )
      hl.bind(
      mod .. " + I",
      layout_bind({
        scrolling = hl.dsp.layout("swapcol r"), -- Scrolling: swap column with left one
        dwindle = hl.dsp.layout("togglesplit"), -- Dwindle: swap window split
        master = hl.dsp.layout("cyclenext"),
        monocle = hl.dsp.layout("cyclenext"), -- Monocle and master: cycle prev window
      })
      )

      hl.bind(
      mod .. " + Space",
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
                wrap_focus = true,
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
      hl.bind("SHIFT + mouse:275", hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"), { transparent = true, non_consuming = true })
      hl.bind(modc .. " + M", hl.dsp.exec_cmd("uwsm-app -- toggle-mute"), { transparent = true, non_consuming = true })
      hl.bind(modc .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm-app -- toggle-mute --mute-all"), { transparent = true, non_consuming = true })
      hl.bind(mod .. " + Q", hl.dsp.window.close())
      hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
      hl.bind(mod .. " + D", hl.dsp.focus({ window = "floating" }))
      hl.bind(mod .. " + S", hl.dsp.focus({ window = "tiled" }))
      hl.bind("Pause", hl.dsp.exec_cmd(playerctl .. " play-pause"))
      hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
      hl.bind(mods .. " + T", hl.dsp.exec_cmd(term .. " --class tmux tmux"))
      hl.bind(mod .. " + F", hl.dsp.exec_cmd(browser))
      hl.bind(mod .. " + E", hl.dsp.exec_cmd(files))
      hl.bind(mod .. " + grave", hl.dsp.exec_cmd(menu))
      hl.bind(mod .. " + Return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
      hl.bind(mods .. " + Return", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("ALT + Tab", hl.dsp.exec_cmd("rofi -show window -modi window"))

      hl.bind(mod .. " + Tab", function ()
          local layouts     = { "scrolling", "dwindle", "master", "monocle" }
          local workspace   = hl.get_active_workspace()
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

      hl.bind(mods .. " + Tab", function ()
          local layouts     = { "monocole", "master", "dwindle", "scrolling" }
          local workspace   = hl.get_active_workspace()
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

      hl.bind(mod .. " + Y", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
      hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(term .. " --title btop btop"))
      hl.bind("XF86Calculator", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(mod .. " + semicolon", hl.dsp.exec_cmd("uwsm-app -- qalculate-gtk"))
      hl.bind(moda .. " + S", hl.dsp.workspace.toggle_special("magic"))
      hl.bind(mods .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))
      hl.bind("Print", hl.dsp.exec_cmd("hyprquickframe -n -d"))
      hl.bind(mod .. " + O", hl.dsp.exec_cmd("uwsm-app -- hyprpicker -a"))
      hl.bind(mods .. " + P", hl.dsp.submap("player"))
      hl.bind(mods .. " + Comma", hl.dsp.window.move({ monitor = "+1", follow = true }))
      hl.bind(mods .. " + Period", hl.dsp.window.move({ monitor = "-1", follow = true }))
      hl.bind(mod .. " + Comma", hl.dsp.focus({ monitor = "+1" }))
      hl.bind(mod .. " + Period", hl.dsp.focus({ monitor = "-1" }))
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol dec"), { repeating = true, locked = true })
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol inc"), { repeating = true, locked = true })
      hl.bind("SHIFT + XF86AudioLowerVolume",
      hl.dsp.exec_cmd(" uwsm-app -- playerVol dec-mini"), { repeating = true, locked = true })
      hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol inc-mini"), { repeating = true, locked = true })
      hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(" uwsm-app -- brightness inc"), { repeating = true, locked = true })
      hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(" uwsm-app -- brightness dec"), { repeating = true, locked = true })

      hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(playerctl .. " play-pause"), { locked = true })
      hl.bind("XF86AudioNext", hl.dsp.exec_cmd(playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(playerctl .. " next"), { locked = true })
      hl.bind("XF86AudioMute", hl.dsp.exec_cmd("uwsm-app -- playerVol mute"), { locked = true })

      hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
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
      hl.bind(
      mod .. " + X",
      layout_bind({
        scrolling = hl.dsp.layout("colresize 0.5"),
      })
      )
      hl.bind(
      mod .. " + mouse_up",
      layout_bind({
        scrolling = hl.dsp.layout("focus left"),
      })
      )
      hl.bind(
      mod .. " + mouse_down",
      layout_bind({
        scrolling = hl.dsp.layout("focus right"),
      })
      )
      hl.bind(
      mods .. " + mouse_up",
      layout_bind({
        scrolling = hl.dsp.focus({ workspace = "e-1" }),
        dwindle = hl.dsp.focus({ workspace = "e-1" }),
        master = hl.dsp.focus({ workspace = "e-1" }),
        monocle = hl.dsp.focus({ workspace = "e-1" }),
      })
      )
      hl.bind(
      mods .. " + mouse_down",
      layout_bind({
        scrolling = hl.dsp.focus({ workspace = "e+1" }),
        dwindle = hl.dsp.focus({ workspace = "e+1" }),
        master = hl.dsp.focus({ workspace = "e+1" }),
        monocle = hl.dsp.focus({ workspace = "e+1" }),
      })
      )
      hl.bind(modc .. " + G", hl.dsp.group.toggle())
    end
    universal_binds()


    hl.bind(modc .. " + H", hl.dsp.group.prev())
    hl.bind(modc .. " + L", hl.dsp.group.next())
    hl.bind(modc .. " + Left", hl.dsp.group.prev())
    hl.bind(modc .. " + Right", hl.dsp.group.next())
    hl.bind(
    mod .. " + H",
    layout_bind({
      scrolling = hl.dsp.layout("move -col"),
      dwindle = hl.dsp.focus({ direction = "left" }),
      master = hl.dsp.focus({ direction = "left" }),
      monocle = hl.dsp.focus({ direction = "left" }),
    })
    )
    hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
    hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
    hl.bind(
    mod .. " + L",
    layout_bind({
      scrolling = hl.dsp.layout("move +col"),
      dwindle = hl.dsp.focus({ direction = "right" }),
      master = hl.dsp.focus({ direction = "right" }),
      monocle = hl.dsp.focus({ direction = "right" }),
    })
    )
    hl.bind(
    mod .. " + Left",
    layout_bind({
      scrolling = hl.dsp.layout("move -col"),
      dwindle = hl.dsp.focus({ direction = "left" }),
      master = hl.dsp.focus({ direction = "left" }),
      monocle = hl.dsp.focus({ direction = "left" }),
    })
    )
    hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "down" }))
    hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "up" }))
    hl.bind(
    mod .. " + Right",
    layout_bind({
      scrolling = hl.dsp.layout("move +col"),
      dwindle = hl.dsp.focus({ direction = "right" }),
      master = hl.dsp.focus({ direction = "right" }),
      monocle = hl.dsp.focus({ direction = "right" }),
    })
    )
    hl.bind(mods .. " + H", hl.dsp.focus({ workspace = "r-1" }))
    hl.bind(mods .. " + L", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind(mods .. " + J", hl.dsp.focus({ workspace = "empty" }))
    hl.bind(mods .. " + Left", hl.dsp.focus({ workspace = "r-1" }))
    hl.bind(mods .. " + Right", hl.dsp.focus({ workspace = "r+1" }))
    hl.bind(mods .. " + Down", hl.dsp.focus({ workspace = "empty" }))


    hl.bind(mod .. " + A", hl.dsp.submap("manage"))
    hl.define_submap("manage", function()
      universal_binds()
      hl.bind(mod .." + P", hl.dsp.window.pin())

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

      hl.bind(
        mod .. " + H",
        layout_bind ({
                  scrolling = hl.dsp.layout("consume_or_expel prev"),
                  dwindle = hl.dsp.window.move({ direction = "left" }),
                  master = hl.dsp.window.move({ direction = "left" }),
                  monocle = hl.dsp.window.move({ direction = "left" }),
        })
      )
      hl.bind(mod .. " + J", hl.dsp.window.move({ direction = "down" }))
      hl.bind(mod .. " + K", hl.dsp.window.move({ direction = "up" }))
      hl.bind(
        mod .. " + L",
        layout_bind ({
                  scrolling = hl.dsp.layout("consume_or_expel next"),
                  dwindle = hl.dsp.window.move({ direction = "right" }),
                  master = hl.dsp.window.move({ direction = "right" }),
                  monocle = hl.dsp.window.move({ direction = "right" }),
        })
      )

      hl.bind(
        mod .. " + Left",
        layout_bind ({
                  scrolling = hl.dsp.layout("consume_or_expel prev"),
                  dwindle = hl.dsp.window.move({ direction = "left" }),
                  master = hl.dsp.window.move({ direction = "left" }),
                  monocle = hl.dsp.window.move({ direction = "left" }),
        })
      )
      hl.bind(mod .. " + Down", hl.dsp.window.move({ direction = "down" }))
      hl.bind(mod .. " + Up", hl.dsp.window.move({ direction = "up" }))
      hl.bind(
        mod .. " + Right",
        layout_bind ({
                  scrolling = hl.dsp.layout("consume_or_expel next"),
                  dwindle = hl.dsp.window.move({ direction = "right" }),
                  master = hl.dsp.window.move({ direction = "right" }),
                  monocle = hl.dsp.window.move({ direction = "right" }),
        })
      )

      hl.bind(modc .. " + H", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(modc .. " + J", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(modc .. " + K", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(modc .. " + L", hl.dsp.window.move({ direction = "right", group_aware = true }))
      hl.bind(modc .. " + Left", hl.dsp.window.move({ direction = "left", group_aware = true }))
      hl.bind(modc .. " + Down", hl.dsp.window.move({ direction = "down", group_aware = true }))
      hl.bind(modc .. " + Up", hl.dsp.window.move({ direction = "up", group_aware = true }))
      hl.bind(modc .. " + Right", hl.dsp.window.move({ direction = "right", group_aware = true }))

      hl.bind(mod .. " + R", hl.dsp.submap("resize"))
      hl.define_submap("resize", function()
        universal_binds()

        hl.bind(mod .. " + Left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), {repeating = true})
        hl.bind(mod .. " + Down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), {repeating = true})
        hl.bind(mod .. " + Up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), {repeating = true})
        hl.bind(mod .. " + Right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), {repeating = true})

        hl.bind(mod .. " + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), {repeating = true})
        hl.bind(mod .. " + J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), {repeating = true})
        hl.bind(mod .. " + K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), {repeating = true})
        hl.bind(mod .. " + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), {repeating = true})

        hl.bind(mod .. " + M", hl.dsp.submap("move"))
        hl.bind(mod .. " + R", hl.dsp.submap("manage"))
        hl.bind(mod .. " + A", hl.dsp.submap("manage"))
        hl.bind("escape", hl.dsp.submap("manage"))
      end)

      hl.bind(mod .. " + M", hl.dsp.submap("move"))
      hl.define_submap("move", function()
        universal_binds()

        hl.bind(mod .. " + Left", hl.dsp.window.move({ x = -10, y = 0, relative = true }), {repeating = true})
        hl.bind(mod .. " + Down", hl.dsp.window.move({ x = 0, y = 10, relative = true }), {repeating = true})
        hl.bind(mod .. " + Up", hl.dsp.window.move({ x = 0, y = -10, relative = true }), {repeating = true})
        hl.bind(mod .. " + Right", hl.dsp.window.move({ x = 10, y = 0, relative = true }), {repeating = true})

        hl.bind(mod .. " + H", hl.dsp.window.move({ x = -10, y = 0, relative = true }), {repeating = true})
        hl.bind(mod .. " + J", hl.dsp.window.move({ x = 0, y = 10, relative = true }), {repeating = true})
        hl.bind(mod .. " + K", hl.dsp.window.move({ x = 0, y = -10, relative = true }), {repeating = true})
        hl.bind(mod .. " + L", hl.dsp.window.move({ x = 10, y = 0, relative = true }), {repeating = true})

        hl.bind(mod .. " + R", hl.dsp.submap("resize"))
        hl.bind(mod .. " + M", hl.dsp.submap("manage"))
        hl.bind(mod .. " + A", hl.dsp.submap("manage"))
        hl.bind("escape", hl.dsp.submap("manage"))
      end)

      hl.bind("Escape", hl.dsp.submap("reset"))

      hl.bind(mod .. " + A", hl.dsp.submap("reset"))
    end)

    hl.define_submap("player", function()
      universal_binds()
      hl.bind("escape", hl.dsp.submap("reset"))
      hl.bind(mods .. " + P", hl.dsp.submap("reset"))
      hl.bind("O", hl.dsp.exec_cmd("uwsm-app -- playerVol inc"), { repeating = true, locked = true })
      hl.bind("I", hl.dsp.exec_cmd("uwsm-app -- playerVol dec"), { repeating = true, locked = true })
      hl.bind("SHIFT + O", hl.dsp.exec_cmd(playerctl .. " next"), { repeating = true, locked = true })
      hl.bind("SHIFT + I", hl.dsp.exec_cmd(playerctl .. " previous"), { repeating = true, locked = true })
      hl.bind("P", hl.dsp.exec_cmd(playerctl .. " play-pause"), { locked = true })
    end)
  '';
}
