{
  lib,
  config,
  pkgs,
  ...
}: let
  playerClass = config.player.class;
  playerCmd = config.player.cmd;
  launches = pkgs.writeShellScriptBin "launches" ''
    dunstctl close-all
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(${playerClass}),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(neo),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(fastfetch),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(btop),9'
    /run/current-system/sw/bin/hyprctl dispatch signalwindow 'class:(cava),9'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 888 462; move 610 609] uwsm app -- kitty --class "cava" cava.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 590 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- kitty --class "neo" neo.sh'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 590 383; move 10 42] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
    /run/current-system/sw/bin/hyprctl dispatch exec '[workspace 1 silent; float; size 888 559; move 610 42] ${playerCmd}'
    systemctl restart --user easyeffects
    systemctl restart --user qpwgraph
    sleep 1
    systemctl restart --user waybar
    dunstctl close-all
    notify-send "~<|Theme loaded!|>~"
  '';
in {
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      nixvim = {
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
          numberLine = true;
        };
      };
      cava.rainbow.enable = true;
      zen-browser.profileNames = [
        "${config.home.username}.Default"
      ];
    };
  };
  systemd.user.services.Theme-Reload = {
    Unit = {
      Description = "Reloads Theme";
      PartOf = ["graphical-session.target"];
      Requires = ["graphical-session.target"];
      After = ["graphical-session.target"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = ''${lib.getExe launches}'';
      Type = "simple";
      Slice = ["session.slice"];
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
