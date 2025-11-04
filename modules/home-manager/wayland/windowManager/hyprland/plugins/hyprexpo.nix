{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  nr = inputs.nix-relic.inputs;
in {
  options.wayland.windowManager.hyprland = {
    hyprexpo.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hyprexpo'';
    };
  };
  config = mkIf cfg.hyprexpo.enable {
    wayland.windowManager.hyprland = mkMerge [
      {
        settings = {
          bind = [
            "$mod, Space, hyprexpo:expo, toggle"
          ];

          plugin = {
            hyprexpo = {
              columns = 3;
              gap_size = 4;
              bg_col = "rgb(${config.lib.stylix.colors.base00})";
              workspace_method = "center current";
              gesture_distance = 300;
            };
          };
        };
        extraConfig = mkIf cfg.layout.hy3.enable ''
          bind = $mod, Space, submap, hyprexpo
          submap = hyprexpo
          bind = $mod, Space, hyprexpo:expo, toggle
          bind = , Escape, hyprexpo:expo, toggle
          bind = $mod, L, workspace, r+1
          bind = $mod, H, workspace, r-1
          bind = $mod, J, workspace, empty
          bind = $mod, Right, workspace, r+1
          bind = $mod, Left, workspace, r-1
          bind = $mod, Down, workspace, empty
          bind = $mod, Space, submap, reset
          bind = , Escape, submap, reset
          submap = reset
        '';
      }
      (mkIf cfg.usingFlake {
        plugins = [
          nr.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo
        ];
        settings.permission = [
          "${nr.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprexpo}/lib/libhyprexpo.so, plugin, allow"
        ];
      })
      (mkIf (! cfg.usingFlake) {
        plugins = [
          pkgs.hyprlandPlugins.hyprexpo
        ];
        settings.permission = [
          "${pkgs.hyprlandPlugins.hyprexpo}/lib/libhyprexpo.so, plugin, allow"
        ];
      })
    ];
  };
}
