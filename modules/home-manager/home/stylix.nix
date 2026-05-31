{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}: let
  playerClass = config.player.class;
  playerCmd = config.player.cmd;
  launches = pkgs.writeShellScriptBin "launches" ''
    dunstctl set-paused true
    dunstctl close-all
    pkill localsend
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(${playerClass})$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(neo)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(fastfetch)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(btop)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(cava)$" })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class cava cava.sh", { workspace = "1 silent", float = true, size = {888, 462}, move = {610, 609} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class btop btop.sh", { workspace = "1 silent", float = true, size = {590, 637}, move = {10, 433} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class neo neo.sh", { workspace = "1 silent", float = true, size = {402, 1030}, move = {1508, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = {590, 383}, move = {10, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {888, 559}, move = {610, 42} })'
    /run/current-system/sw/bin/hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- localsend_app --hidden")'
    systemctl restart --user easyeffects
    systemctl restart --user qpwgraph
    sleep 1
    systemctl restart --user waybar
    dunstctl set-paused false
    dunstctl close-all
    notify-send "|-<(Theme Loaded)>-|"
  '';
  iconColour = osConfig.nix-relic.icons.colour;
in {
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
    icons = {
      enable = true;
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [
          "${iconColour}"
        ];
      };
      dark = "Tela-circle-${iconColour}";
      light = "Tela-circle-${iconColour}";
    };
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      hyprland.enable = false;
      nixvim = {
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
          numberLine = true;
        };
      };
      cava.rainbow.enable = true;
      zen-browser = {
        profileNames = [
          "${config.home.username}.Default"
        ];
        opacity = {
          enable = true;
          override.applications = 0.65;
        };
      };
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
