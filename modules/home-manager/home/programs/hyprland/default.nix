{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.wayland.windowManager.hyprland;
  playerCmd = config.player.cmd;
  playerCmdGame = config.player.cmdGame;
  playerClass = config.player.class;
in {
  wayland.windowManager.hyprland = lib.mkMerge [
    {
      enable = true;
      package = null;
      portalPackage = null;
      xwayland.enable = false;
      systemd = {
        # disable the systemd integration, as it conflicts with uwsm.
        enable = false;
        variables = ["--all"];
      };
    }
  ];
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
    (nr.hyprgame.override {
      wallpaper = cfg.liveWallpaper.path;
      extraKills = ''
        hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(${playerClass})$" })'
          hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(neo)$" })'
          hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(fastfetch)$" })'
          hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(btop)$" })'
          hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(cava)$" })'
          hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmdGame}", { workspace = "1 silent", float = true, size = {1118, 710}, move = {401, 145} })'
      '';
      extraLaunch = ''
        hyprctl dispatch 'hl.dsp.window.kill({ window = "class:^(${playerClass})$" })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class cava cava.sh", { workspace = "1 silent", float = true, size = {888, 462}, move = {610, 609} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class btop btop.sh", { workspace = "1 silent", float = true, size = {590, 637}, move = {10, 433} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class neo neo.sh", { workspace = "1 silent", float = true, size = {402, 1030}, move = {1508, 42} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = {590, 383}, move = {10, 42} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {888, 559}, move = {610, 42} })'

      '';
    })
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
    };
  };
}
