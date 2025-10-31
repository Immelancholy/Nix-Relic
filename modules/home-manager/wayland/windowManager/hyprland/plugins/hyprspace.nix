{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    useHyprspace = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hyprspace'';
    };
  };
  config = mkIf cfg.useHyprspace {
    wayland.windowManager.hyprland = mkMerge [
      {
        settings = {
          bind = [
            "$mod, Tab, overview:toggle"
          ];

          plugin = {
            overview = {
              onBottom = true;
              workspaceMargin = 11;
              workspaceBorderSize = 2;
              centerAligned = true;
              panelHeight = 320;
              drawActiveWorkspace = true;
              switchOnDrop = true;
              affectStrut = false;

              workspaceActiveBorder = "rgba($mauveff)";
              workspaceInactiveBorder = "rgba($lavendercc)";
              disableBlur = false;
            };
          };
        };
      }
      (mkIf cfg.usingFlake {
        plugins = [
          inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
        ];
        settings.permission = [
          "${inputs.Hyprspace.packages.${pkgs.system}.Hyprspace}/lib/libHyprspace.so, plugin, allow"
        ];
      })
      (mkIf (! cfg.usingFlake) {
        plugins = [
          pkgs.hyprlandPlugins.hyprspace
        ];
        settings.permission = [
          "${pkgs.hyprlandPlugins.hyprspace}/lib/libHyprspace.so, plugin, allow"
        ];
      })
    ];
  };
}
