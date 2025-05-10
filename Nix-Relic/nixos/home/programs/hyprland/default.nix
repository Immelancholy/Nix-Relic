{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.wayland.windowManager.hyprland;
  nrm = inputs.nix-relic-modules.packages.${pkgs.system};
in {
  wayland.windowManager.hyprland = lib.mkMerge [
    {
      enable = true;
      package = null;
      portalPackage = null;
      usingFlake = false;
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
      wallpaper = config.wayland.windowManager.hyprland.liveWallpaper.path;
      player = config.player.cmd;
      pclass = config.player.class;
    })
  ];

  imports = [
    ./hyprconf
  ];
}
