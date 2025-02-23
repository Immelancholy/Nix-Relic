{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
    ];
    extraConfig = ''
      bind = Alt, Tab, overview:toggle
      bind = Alt+Shift, Tab, overview:toggle, all

      plugin {
        overview {
          onBottom = true
          workspaceMargin = 5
          workspaceBorderSize = 4
          centerAligned = true
          panelHeight = 320
          drawActiveWorkspace = true

          workspaceActiveBorder = rgba(cba6f7ff)
        }
      }
    '';
  };
}
