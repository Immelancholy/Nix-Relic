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
    wayland.windowManager.hyprland = {
      plugins = [
        # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
        pkgs.hyprlandPlugins.hyprspace
      ];
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
    };
  };
}
