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
      bind = Alt, Tab, exec, overview:toggle
      bind = Alt+Shift, Tab, exec, overview:toggle all

      plugin {
        overview {
          onBottom = true
          workspaceMargin = 5
          workspaceBorderSize = 4
          centerAligned = true
        }
      }
    '';
  };
}
