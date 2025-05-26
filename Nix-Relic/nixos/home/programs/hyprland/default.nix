{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.wayland.windowManager.hyprland;
  playerCmd = config.player.cmd;
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};
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
        inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
        inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
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
    (nrm.hyprgame.override {
      wallpaper = cfg.liveWallpaper.path;
      extraKills = ''
        hyprctl dispatch signalwindow 'class:(mpd.ghostty.screen1),9'
          hyprctl dispatch signalwindow 'class:(neo.ghostty.screen1),9'
          hyprctl dispatch signalwindow 'class:(fastfetch.ghostty.screen1),9'
          hyprctl dispatch signalwindow 'class:(btop.ghostty.screen1),9'
          hyprctl dispatch signalwindow 'class:(cava.ghostty.screen1),9'
          hyprctl dispatch exec '[workspace 1 silent; float; size 1118 710; move 401 145] ${playerCmd}'
      '';
      extraLaunch = ''
        hyprctl dispatch signalwindow 'class:(mpd.ghostty.screen1),9'
          hyprctl dispatch exec '[workspace 1 silent; float; size 858 462; move 640 609] uwsm app -- ghostty --window-padding-x=0 --window-padding-y=0 --font-size=4 --class=cava.ghostty.screen1 -e cava -p "$XDG_CONFIG_HOME"/cava/vcConfig'
          hyprctl dispatch exec '[workspace 1 silent; float; size 620 637; move 10 433] uwsm app -- ghostty --font-size=9 --class=btop.ghostty.screen1 -e btop'
          hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- ghostty --window-padding-x=0 --window-padding-y=0 --class=neo.ghostty.screen1 -e neo.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 620 383; move 10 42] env class="fastfetch" uwsm app -- ghostty --class=fastfetch.ghostty.screen1'
          hyprctl dispatch exec '[workspace 1 silent; float; size 858 559; move 640 42] ${playerCmd}'
      '';
    })
  ];

  imports = [
    ./hyprconf
  ];
}
