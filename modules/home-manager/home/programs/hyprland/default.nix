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
      configType = "hyprlang";
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
        hyprctl dispatch signalwindow 'class:(${playerClass}),15'
          hyprctl dispatch signalwindow 'class:(neo),15'
          hyprctl dispatch signalwindow 'class:(fastfetch),15'
          hyprctl dispatch signalwindow 'class:(btop),15'
          hyprctl dispatch signalwindow 'class:(cava),15'
          hyprctl dispatch exec '[workspace 1 silent; float; size 1118 710; move 401 145] ${playerCmdGame}'
      '';
      extraLaunch = ''
        hyprctl dispatch signalwindow 'class:(${playerClass}),15'
          hyprctl dispatch exec '[workspace 1 silent; float; size 888 462; move 610 609] uwsm app -- kitty --class "cava" cava.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 590 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- kitty --class "neo" neo.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 590 383; move 10 42] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
          hyprctl dispatch exec '[workspace 1 silent; float; size 888 559; move 610 42] ${playerCmd}'

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
