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
          bind = $mod, L, hyprexpo:expo, off
          bind = $mod, H, hyprexpo:expo, off
          bind = $mod, J, hyprexpo:expo, off
          bind = $mod, Right, hyprexpo:expo, off
          bind = $mod, Left, hyprexpo:expo, off
          bind = $mod, Down, hyprexpo:expo, off
          bindn = , mouse:272, submap, reset
          bindn = , mouse:273, submap, reset
          bindn = , mouse:274, submap, reset
          bind = $mod, Space, submap, reset
          bind = $mod, L, submap, reset
          bind = $mod, H, submap, reset
          bind = $mod, J, submap, reset
          bind = $mod, Right, submap, reset
          bind = $mod, Left, submap, reset
          bind = $mod, Down, submap, reset
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
