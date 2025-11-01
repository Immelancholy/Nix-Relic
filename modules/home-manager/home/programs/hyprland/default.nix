{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.wayland.windowManager.hyprland;
  playerCmd = config.player.cmd;
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
        nrm.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
        nrm.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
        nrm.hyprland-easymotion.packages.${pkgs.system}.hyprland-easymotion
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
    (nr.launcher.override {
      playerClass = "${playerClass}";
      playerCmd = "${playerCmd}";
    })
    (nr.hyprgame.override {
      wallpaper = cfg.liveWallpaper.path;
      extraKills = ''
        hyprctl dispatch signalwindow 'class:(${playerClass}),9'
          hyprctl dispatch signalwindow 'class:(neo),9'
          hyprctl dispatch signalwindow 'class:(fastfetch),9'
          hyprctl dispatch signalwindow 'class:(btop),9'
          hyprctl dispatch signalwindow 'class:(cava),9'
          hyprctl dispatch exec '[workspace 1 silent; float; size 1118 710; move 401 145] ${playerCmd}'
      '';
    })
  ];

  imports = [
    ./hyprconf
  ];
}
