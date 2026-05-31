{
  config,
  pkgs,
  lib,
  ...
}: let
  playerCmd = config.player.cmd;
  playerClass = config.player.class;
  launches = pkgs.writeShellScriptBin "launches" ''
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(${playerClass})$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(neo)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(fastfetch)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(btop)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(cava)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class cava cava.sh", { workspace = "1 silent", float = true, size = {888, 462}, move = {610, 609} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class btop btop.sh", { workspace = "1 silent", float = true, size = {590, 637}, move = {10, 433} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class neo neo.sh", { workspace = "1 silent", float = true, size = {402, 1030}, move = {1508, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = {590, 383}, move = {10, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {888, 559}, move = {610, 42} })'
  '';
  inherit (lib.generators) mkLuaInLine;
in {
  home.packages = [
    launches
  ];
  wayland.windowManager.hyprland = {
    extraConfig = ''
      for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
        hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
      end
    '';
    submaps = {
      player.settings = {
        bind = [
          {
            _args = [
              "escape"
              (mkLuaInLine "hl.dsp.submap(\"reset\")")
            ];
          }
          {
            _args = [
              (mkLuaInLine "mod .. \" + P\"")
              (mkLuaInLine "hl.dsp.submap(\"reset\")")
            ];
          }
        ];
        bindl = [
          {
            _args = [
              "P"
              (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
            ];
          }
        ];
        bindel = [
          {
            _args = [
              "O"
              (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- playerVol inc\")")
            ];
          }
          {
            _args = [
              "I"
              (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- playerVol dec\")")
            ];
          }
          {
            _args = [
              "SHIFT + O"
              (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" next\")")
            ];
          }
          {
            _args = [
              "SHIFT + I"
              (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" previous\")")
            ];
          }
        ];
      };
    };
    settings = {
      bindm = [
        {
          _args = [
            (mkLuaInLine "mod .. \" + mouse:272\"")
            (mkLuaInLine "hl.dsp.window.drag()")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + mouse:273\"")
            (mkLuaInLine "hl.dsp.window.resize()")
          ];
        }
      ];
      bind = [
        {
          _args = [
            (mkLuaInLine "mod .. \" + B\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"binds.sh\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + W\"")
            (mkLuaInLine "hl.dsp.widnwo.float({action = \"toggle\" }))")
          ];
        }
        {
          _args = [
            "Pause"
            (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + T\"")
            (mkLuaInLine "hl.dsp.exec_cmd(term)")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + T\"")
            (mkLuaInLine "hl.dsp.exec_cmd(term .. \" --class tmux tmux\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + F\"")
            (mkLuaInLine "hl.dsp.exec_cmd(browser)")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + E\"")
            (mkLuaInLine "hl.dsp.exec_cmd(files)")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + grave\"")
            (mkLuaInLine "hl.dsp.exec_cmd(menu)")
          ];
        }
        {
          _args = [
            "Alt + Return"
            (mkLuaInLine "hl.dsp.fullscreen({ mode = \"fullscreen\" action = \"toggle\" })")
          ];
        }
        {
          _args = [
            "Alt + Shift + Return"
            (mkLuaInLine "hl.dsp.fullscreen({ mode = \"maximized\" action = \"toggle\" })")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Tab\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"rofi -show window -modi window\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + U\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"launches\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Delete\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"rofi -show power-menu -modi power-menu:rofi-power-menu\")")
          ];
        }
        {
          _args = [
            "Ctrl + Shift + L"
            (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- swaylock -fF\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + N\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"rofi -show Cliphist -modi Cliphist:cliphist.sh\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Apostrophe\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"rofi -show emoji nerdy -modi emoji,nerdy\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + G\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"hyprgame\")")
          ];
        }
        {
          _args = [
            "Ctrl + Shift + Escape"
            (mkLuaInLine "hl.dsp.exec_cmd(term .. \" --title btop btop\")")
          ];
        }
        {
          _args = [
            "XF86Calculator"
            (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- qalculate-gtk\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Colon\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- qalculate-gtk\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "moda .. \" + S\"")
            (mkLuaInLine "hl.dsp.workspace.toggle_special(\"magic\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "moda .. \" + S\"")
            (mkLuaInLine "hl.dsp.window.move({ workspace = \"special:magic\" })")
          ];
        }
        {
          _args = [
            "Print"
            (mkLuaInLine "hl.dsp.exec_cmd(\"hyprquickframe\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + O\"")
            (mkLuaInLine "hl.dsp.exec_cmd(\"uwsm-app -- hyprpicker -a\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + P\"")
            (mkLuaInLine "hl.dsp.submap(\"player\")")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + Comma\"")
            (mkLuaInLine "hl.dsp.window.move({ monitor = \"+1\", follow = true })")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mods .. \" + Period\"")
            (mkLuaInLine "hl.dsp.window.move({ monitor = \"-1\", follow = true })")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Comma\"")
            (mkLuaInLine "hl.dsp.focus({ monitor = \"+1\" })")
          ];
        }
        {
          _args = [
            (mkLuaInLine "mod .. \" + Period\"")
            (mkLuaInLine "hl.dsp.focus({ monitor = \"-1\" })")
          ];
        }
      ];
      bindl = [
        {
          _args = [
            "XF86AudioPlay"
            (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" next\")")
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (mkLuaInLine "hl.dsp.exec_cmd(playerctl .. \" next\")")
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- playerVol mute\")")
          ];
        }
      ];
      bindel = [
        {
          _args = [
            "XF86AudioLowerVolume"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- playerVol dec\")")
          ];
        }
        {
          _args = [
            "XF86AudioRaiseVolume"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- playerVol inc\")")
          ];
        }
        "Shift, XF86AudioLowerVolume, exec, uwsm-app -- playerVol dec-mini" # decrease volume of mpd
        "Shift, XF86AudioRaiseVolume, exec, uwsm-app -- playerVol inc-mini" # increase volume of mpd
        {
          _args = [
            "Shift + XF86AudioLowerVolume"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- playerVol dec-mini\")")
          ];
        }
        {
          _args = [
            "Shift + XF86AudioRaiseVolume"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- playerVol inc-mini\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- brightness inc\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (mkLuaInLine "hl.dsp.exec_cmd(\" uwsm-app -- brightness dec\")")
          ];
        }
      ];
    };
  };
}
