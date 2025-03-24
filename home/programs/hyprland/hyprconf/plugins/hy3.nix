{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hy3.packages.${pkgs.system}.hy3
    ];
    extraConfig = ''
      plugin {
        hy3 {
          autotile {
            enable = true
            trigger_height = 640
            trigger_width = 0
          }
        }
      }
    '';
  };
}
