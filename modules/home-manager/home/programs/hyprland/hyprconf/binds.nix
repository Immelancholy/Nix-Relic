{
  config,
  pkgs,
  lib,
  ...
}: let
  playerCmd = config.player.cmd;
  playerClass = config.player.class;
  launches = pkgs.writeShellScriptBin "launches" ''
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.signal({ signal = "9", class = "^(${playerClass})$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.signal({ signal = "9", class = "^(neo)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.signal({ signal = "9", class = "^(fastfetch)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.signal({ signal = "9", class = "^(btop)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.signal({ signal = "9", class = "^(cava)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class cava cava.sh", { workspace = "1 silent", float = true, size = {888, 462}, move = {610, 609} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class btop btop.sh", { workspace = "1 silent", float = true, size = {590, 637}, move = {10, 433} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class neo neo.sh", { workspace = "1 silent", float = true, size = {402, 1030}, move = {1508, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = {590, 383}, move = {10, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {888, 559}, move = {610, 42} })'
  '';
in {
  home.packages = [
    launches
  ];
  wayland.windowManager.hyprland =
    /*
    Lua
    */
    {
      extraConfig = ''
        for i = 1, 10 do
          local key = i % 10 -- 10 maps to key 0
          hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
          hl.bind(mods .. " + " .. key, hl.dsp.window.move({ workspace = i }))
        end

        hl.bind(mod .. " + B", hl.dsp.exec_cmd("binds.sh"))
        hl.bind(mod .. " + W", hl.dsp.window.float({ action = "toggle" }))
        hl.bind("Pause", hl.dsp.exec_cmd(playerctl .. " play-pause"))
        hl.bind(mod .. " + T", hl.dsp.exec_cmd(term))
        hl.bind(mods .. " + T", hl.dsp.exec_cmd(term .. " --class tmux tmux"))
        hl.bind(mods .. " + F", hl.dsp.exec_cmd(browser))
        hl.bind(mods .. " + E", (hl.dsp.exec_cmd(files))
        hl.bind(mods .. " + grave", (hl.dsp.exec_cmd(menu))
        hl.bind("Alt + Return", hl.dsp.fullscreen({ mode = "fullscreen", action = "toggle" }))
        hl.bind("Alt + Shift + Return", hl.dsp.fullscreen({ mode = "maximized", action = "toggle" }))
        hl.bind(mod .. " + Tab", hl.dsp.exec_cmd("rofi -show window -modi window"))
        hl.bind(mods .. " + U", hl.dsp.exec_cmd("launches"))
        hl.bind(mod .. " + Delete", hl.dsp.exec_cmd("rofi -show power-menu -modi power-menu:rofi-power-menu"))
        hl.bind("Ctrl + Shift + L", hl.dsp.exec_cmd("uwsm-app -- swaylock -fF"))
        hl.bind(mod .. " + N", hl.dsp.exec_cmd("rofi -show Cliphist -modi Cliphist:cliphist.sh"))
        hl.bind(mod .. " + Apostrophe", hl.dsp.exec_cmd("rofi -show emoji nerdy -modi emoji,nerdy"))
        hl.bind(mod .. " + G", hl.dsp.exec_cmd("hyprgame"))
        hl.bind("Ctrl + Shift + Escape", hl.dsp.exec_cmd(term .. " --title btop btop"))
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

        hl.bindel("XF86AudioLowerVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol dec"))
        hl.bindel("XF86AudioRaiseVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol inc"))
        hl.bindel("Shift + XF86AudioLowerVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol dec-mini"))
        hl.bindel("Shift + XF86AudioRaiseVolume", hl.dsp.exec_cmd(" uwsm-app -- playerVol inc-mini"))
        hl.bindel("XF86MonBrightnessUp", hl.dsp.exec_cmd(" uwsm-app -- brightness inc"))
        hl.bindel("XF86MonBrightnessDown", hl.dsp.exec_cmd(" uwsm-app -- brightness dec"))

        hl.bindl("XF86AudioPlay", hl.dsp.exec_cmd(playerctl .. " play-pause"))
        hl.bindl("XF86AudioNext", hl.dsp.exec_cmd(playerctl .. " next"))
        hl.bindl("XF86AudioPrev", hl.dsp.exec_cmd(playerctl .. " next"))
        hl.bindl("XF86AudioMute", hl.dsp.exec_cmd("uwsm-app -- playerVol mute"))

        hl.bindm(mod .. " + mouse:272", hl.dsp.window.drag())
        hl.bindm(mod .. " + mouse:273", hl.dsp.window.resize())

        hl.define_submap("player", function()
          hl.bind("escape", hl.dsp.submap("reset"))
          hl.bind(mod .. " + P", hl.dsp.submap("reset"))
          hl.bindel("O", hl.dsp.exec_cmd("uwsm-app -- playerVol inc"))
          hl.bindel("I", hl.dsp.exec_cmd("uwsm-app -- playerVol dec"))
          hl.bindel("SHIFT + O", hl.dsp.exec_cmd(playerctl .. " next"))
          hl.bindel("SHIFT + I", hl.dsp.exec_cmd(playerctl .. " previous"))
          hl.bindl("P", hl.dsp.exec_cmd(playerctl .. " play-pause"))
        end)
      '';
    };
}
