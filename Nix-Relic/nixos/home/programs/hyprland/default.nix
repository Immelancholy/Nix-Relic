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
        inputs.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
      ];
      settings = {
        bind = [
          "$mod, G, easymotion, action:hyprctl dispatch focuswindow address:{}"
        ];
        plugin = {
          easymotion = {
            textcolor = "rgba(${config.lib.stylix.colors.base05}ff)";
            bgcolor = "rgba(${config.lib.stylix.colors.base00}bb)";
            bordercolor = "rgba($mauveff) rgba($tealff) rgba($rosewaterff) 40deg";
            blur = 1;
            textpadding = 8;
            textsize = 35;
            bordersize = 2;
            fullscreen_action = "maximize";
          };
        };
      };
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
        hyprctl dispatch signalwindow 'class:(mpd),9'
          hyprctl dispatch signalwindow 'class:(neo),9'
          hyprctl dispatch signalwindow 'class:(fastfetch),9'
          hyprctl dispatch signalwindow 'class:(btop),9'
          hyprctl dispatch signalwindow 'class:(cava),9'
          hyprctl dispatch exec '[workspace 1 silent; float; size 1118 710; move 401 145] ${playerCmd}'
      '';
      extraLaunch = ''
        hyprctl dispatch signalwindow 'class:(mpd),9'
          hyprctl dispatch exec '[workspace 1 silent; float; size 888 462; move 610 609] uwsm app -- kitty --class "cava" cava.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 590 637; move 10 433] uwsm app -- kitty --class "btop" btop.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 402 1030; move 1508 42]  uwsm app -- kitty --class "neo" neo.sh'
          hyprctl dispatch exec '[workspace 1 silent; float; size 590 383; move 10 42] uwsm app -- kitty --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"'
          hyprctl dispatch exec '[workspace 1 silent; float; size 888 559; move 610 42] ${playerCmd}'
      '';
    })
  ];

  imports = [
    ./hyprconf
  ];
}
