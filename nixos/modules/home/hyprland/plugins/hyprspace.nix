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
      description = ''Use Hy3 tyling style'';
    };
  };
  config = mkIf cfg.useHyprspace {
    wayland.windowManager.hyprland = {
      plugins = [
        inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      ];
      settings = {
        bind = [
          "$Alt, Tab, overview:toggle"
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

            workspaceActiveBorder = "rgba(cba6f7ff)";
            workspaceInactiveBorder = "rgba(b4befecc)";
            disableBlur = false;
          };
        };
      };
    };
  };
}
