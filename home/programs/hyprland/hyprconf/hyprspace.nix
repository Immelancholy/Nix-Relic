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
          workspaceMargin = 11
          workspaceBorderSize = 3
          centerAligned = true
          panelHeight = 320
          drawActiveWorkspace = true
          #gapsIn = 3
          #gapsOut = 8
          switchOnDrop = true

          workspaceActiveBorder = rgba(cba6f7ff)
          workspaceInactiveBorder = rgba(b4befecc)
          disableBlur = true
        }
      }
    '';
  };
}
