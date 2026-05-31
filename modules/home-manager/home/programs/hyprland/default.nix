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
  nrm = inputs.nix-relic.inputs;
in {
  wayland.windowManager.hyprland = lib.mkMerge [
    {
      enable = true;
      package = null;
      portalPackage = null;
      usingFlake = true;
      xwayland.enable = false;
      systemd = {
        # disable the systemd integration, as it conflicts with uwsm.
        enable = false;
        variables = ["--all"];
      };
    }
    (lib.mkIf cfg.usingFlake {
      plugins = [
        nrm.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.csgo-vulkan-fix
      ];
    })
    (lib.mkIf (! cfg.usingFlake) {
      plugins = [
        pkgs.hyprlandPlugins.csgo-vulkan-fix
      ];
    })
  ];
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
    (nr.hyprgame.override {
      wallpaper = cfg.liveWallpaper.path;
      extraKills = ''
        hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(${playerClass})$" })'
          hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(neo)$" })'
          hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(fastfetch)$" })'
          hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(btop)$" })'
          hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(cava)$" })'
          hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {1118, 710}, move = {401, 145} })'
      '';
      extraLaunch = ''
        hyprctl dispatch 'hl.dps.window.signal({ signal = "9", class = "^(${playerClass})$" })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class cava cava.sh", { workspace = "1 silent", float = true, size = {888, 462}, move = {610, 609} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class btop btop.sh", { workspace = "1 silent", float = true, size = {590, 637}, move = {10, 433} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class neo neo.sh", { workspace = "1 silent", float = true, size = {402, 1030}, move = {1508, 42} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("uwsm app -- kitty --class fastfetch kitty @ launch --type overlay --env class=fastfetch", { workspace = "1 silent", float = true, size = {590, 383}, move = {10, 42} })'
          hyprctl dispatch 'hl.dsp.exec_cmd("${playerCmd}", { workspace = "1 silent", float = true, size = {888, 559}, move = {610, 42} })'

      '';
    })
  ];
  services.hyprpaper = {
    settings = {
      splash = false;
    };
  };

  imports = [
    ./hyprconf
  ];
}
