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
            "$mod, Space, overview:toggle"
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
          nr.Hyprspace.packages.${pkgs.stdenv.hostPlatform.system}.Hyprspace
        ];
        settings.permission = [
          "${nr.Hyprspace.packages.${pkgs.stdenv.hostPlatform.system}.Hyprspace}/lib/libHyprspace.so, plugin, allow"
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
