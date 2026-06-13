{ config, ... }:
let
  cfg = config.wayland.windowManager.hyprland;
  inherit (config.player) title;

  wallpaper = "${
    if cfg.liveWallpaper.enable then
      ''
        hl.timer(function()
              hl.exec_cmd("uwsm-app -- mpvpaper -f -p -o \"--loop no-audio\" '*' ${cfg.liveWallpaper.path}")
            end, {timeout = 5, type = "oneshot"})
            hl.timer(function()
              hl.exec_cmd("systemctl stop --user hyprpaper")
            end, { timeout = 5, type = "oneshot" })
      ''
    else
      ""
  }";
  wallpaperKill = "${if cfg.liveWallpaper.enable then "hl.exec_cmd(\"pkill mpvpaper\")" else ""}";
in
{
  xdg.configFile."hypr/lua/autostart.lua".text = /* Lua */ ''
    hl.on("hyprland.start", function()
      hl.timer(function()
        hl.exec_cmd(Discord)
        hl.exec_cmd(Browser, { workspace = "2 silent" })
        hl.exec_cmd("uwsm-app -- waybar")
        hl.exec_cmd("dunstctl set-paused true")
        hl.exec_cmd("dunstctl close-all")
        hl.exec_cmd("systemctl restart --user easyeffects")
        hl.exec_cmd("systemctl restart --user qpwgraph")
        hl.timer(function()
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-cava relic-cava", { workspace = "1 silent", float = true, size = { 888, 456 }, move = { 610, 615 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-btop relic-btop", { workspace = "1 silent", float = true, size = { 590, 615 }, move = { 10, 455 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-neo relic-neo", { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = { 590, 405 }, move = { 10, 42 } }))
          hl.dispatch(hl.dsp.exec_cmd(Player .. " -b on", { workspace = "1 silent", float = true, size = { 888, 565 }, move = { 610, 42 } }))
        end, {timeout = 5, type = "oneshot"})
        ${wallpaper}
        hl.timer(function()
          hl.exec_cmd("sleep 1; dunstctl set-paused false")
          hl.exec_cmd("dunstctl close-all")
          hl.exec_cmd("sleep 2; notify-send \"|-<(Theme Loaded)>-|\"")
        end, {timeout = 5, type = "oneshot"})
      end, { timeout = 1, type = "oneshot" })
    end)
    hl.on("config.reloaded", function()
      hl.timer(function()
        hl.exec_cmd("dunstctl set-paused true")
        hl.exec_cmd("dunstctl close-all")
        hl.exec_cmd("systemctl restart --user easyeffects")
        hl.exec_cmd("systemctl restart --user qpwgraph")
        hl.exec_cmd("pkill localsend")
        hl.dispatch(hl.dsp.window.kill({ window = "title:^(${title})$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-neo)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-fastfetch)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-btop)$" }))
        hl.dispatch(hl.dsp.window.kill({ window = "title:^(relic-cava)$" }))
        hl.timer(function()
          hl.exec_cmd("uwsm-app -- localsend_app --hidden")
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-cava relic-cava", { workspace = "1 silent", float = true, size = { 888, 456 }, move = { 610, 615 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-btop relic-btop", { workspace = "1 silent", float = true, size = { 590, 615 }, move = { 10, 455 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-neo relic-neo", { workspace = "1 silent", float = true, size = { 402, 1030 }, move = { 1508, 42 } }))
          hl.dispatch(hl.dsp.exec_cmd("uwsm-app -- kitty --title relic-fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = { 590, 405 }, move = { 10, 42 } }))
          hl.dispatch(hl.dsp.exec_cmd(Player .. " -b on", { workspace = "1 silent", float = true, size = { 888, 565 }, move = { 610, 42 } }))
        end, {timeout = 5, type = "oneshot"})
        ${wallpaperKill}
        ${wallpaper}
        hl.timer(function()
          hl.exec_cmd("sleep 1; dunstctl set-paused false")
          hl.exec_cmd("dunstctl close-all")
          hl.exec_cmd("sleep 2; notify-send \"|-<(Theme Loaded)>-|\"")
        end, {timeout = 5, type = "oneshot"})
      end, { timeout = 1, type = "oneshot" })
    end)
  '';
}
