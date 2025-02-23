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
          panelBorderWidth = 4
          drawActiveWorkspace = true

          panelColor = rgba(b4befecc) rgba(6c7086cc) 45deg
          panelBorderColor = rgba(cba6f7ff) rgba(89dcebff) rgba(f5e0dcff) 40deg
        }
      }
    '';
  };
}
