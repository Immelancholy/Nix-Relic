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
  inherit (lib.generators) mkLuaInline;
in {
  home.packages = [
    launches
  ];
  wayland.windowManager.hyprland = {
    extraConfig = ''
      for i = 1, 10 do
        local key = i % 10 -- 10 maps to key 0
        hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i}))
        hl.bind(mods .. " + " .. key, hl.dsp.window.move({ workspace = i }))
      end
    '';
    submaps = {
      player.settings = {
        bind = [
          {
            _args = [
              "escape"
              (mkLuaInline "hl.dsp.submap(\"reset\")")
            ];
          }
          {
            _args = [
              (mkLuaInline "mod .. \" + P\"")
              (mkLuaInline "hl.dsp.submap(\"reset\")")
            ];
          }
        ];
        bindl = [
          {
            _args = [
              "P"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
            ];
          }
        ];
        bindel = [
          {
            _args = [
              "O"
              (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- playerVol inc\")")
            ];
          }
          {
            _args = [
              "I"
              (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- playerVol dec\")")
            ];
          }
          {
            _args = [
              "SHIFT + O"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" next\")")
            ];
          }
          {
            _args = [
              "SHIFT + I"
              (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" previous\")")
            ];
          }
        ];
      };
    };
    settings = {
      bindm = [
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:272\"")
            (mkLuaInline "hl.dsp.window.drag()")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:273\"")
            (mkLuaInline "hl.dsp.window.resize()")
          ];
        }
      ];
      bind = [
        {
          _args = [
            (mkLuaInline "mod .. \" + B\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"binds.sh\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + W\"")
            (mkLuaInline "hl.dsp.widnwo.float({action = \"toggle\" })")
          ];
        }
        {
          _args = [
            "Pause"
            (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + T\"")
            (mkLuaInline "hl.dsp.exec_cmd(term)")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + T\"")
            (mkLuaInline "hl.dsp.exec_cmd(term .. \" --class tmux tmux\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + F\"")
            (mkLuaInline "hl.dsp.exec_cmd(browser)")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + E\"")
            (mkLuaInline "hl.dsp.exec_cmd(files)")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + grave\"")
            (mkLuaInline "hl.dsp.exec_cmd(menu)")
          ];
        }
        {
          _args = [
            "Alt + Return"
            (mkLuaInline "hl.dsp.fullscreen({ mode = \"fullscreen\" action = \"toggle\" })")
          ];
        }
        {
          _args = [
            "Alt + Shift + Return"
            (mkLuaInline "hl.dsp.fullscreen({ mode = \"maximized\" action = \"toggle\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Tab\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"rofi -show window -modi window\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + U\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"launches\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Delete\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"rofi -show power-menu -modi power-menu:rofi-power-menu\")")
          ];
        }
        {
          _args = [
            "Ctrl + Shift + L"
            (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- swaylock -fF\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + N\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"rofi -show Cliphist -modi Cliphist:cliphist.sh\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Apostrophe\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"rofi -show emoji nerdy -modi emoji,nerdy\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + G\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"hyprgame\")")
          ];
        }
        {
          _args = [
            "Ctrl + Shift + Escape"
            (mkLuaInline "hl.dsp.exec_cmd(term .. \" --title btop btop\")")
          ];
        }
        {
          _args = [
            "XF86Calculator"
            (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- qalculate-gtk\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Colon\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- qalculate-gtk\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "moda .. \" + S\"")
            (mkLuaInline "hl.dsp.workspace.toggle_special(\"magic\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + S\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = \"special:magic\" })")
          ];
        }
        {
          _args = [
            "Print"
            (mkLuaInline "hl.dsp.exec_cmd(\"hyprquickframe\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + O\"")
            (mkLuaInline "hl.dsp.exec_cmd(\"uwsm-app -- hyprpicker -a\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + P\"")
            (mkLuaInline "hl.dsp.submap(\"player\")")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + Comma\"")
            (mkLuaInline "hl.dsp.window.move({ monitor = \"+1\", follow = true })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mods .. \" + Period\"")
            (mkLuaInline "hl.dsp.window.move({ monitor = \"-1\", follow = true })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Comma\"")
            (mkLuaInline "hl.dsp.focus({ monitor = \"+1\" })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + Period\"")
            (mkLuaInline "hl.dsp.focus({ monitor = \"-1\" })")
          ];
        }
      ];
      bindl = [
        {
          _args = [
            "XF86AudioPlay"
            (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" play-pause\")")
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" next\")")
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (mkLuaInline "hl.dsp.exec_cmd(playerctl .. \" next\")")
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- playerVol mute\")")
          ];
        }
      ];
      bindel = [
        {
          _args = [
            "XF86AudioLowerVolume"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- playerVol dec\")")
          ];
        }
        {
          _args = [
            "XF86AudioRaiseVolume"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- playerVol inc\")")
          ];
        }
        "Shift, XF86AudioLowerVolume, exec, uwsm-app -- playerVol dec-mini" # decrease volume of mpd
        "Shift, XF86AudioRaiseVolume, exec, uwsm-app -- playerVol inc-mini" # increase volume of mpd
        {
          _args = [
            "Shift + XF86AudioLowerVolume"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- playerVol dec-mini\")")
          ];
        }
        {
          _args = [
            "Shift + XF86AudioRaiseVolume"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- playerVol inc-mini\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- brightness inc\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (mkLuaInline "hl.dsp.exec_cmd(\" uwsm-app -- brightness dec\")")
          ];
        }
      ];
    };
  };
}
