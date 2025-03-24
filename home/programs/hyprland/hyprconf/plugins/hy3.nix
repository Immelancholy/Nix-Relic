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
            trigger_height = 0
            trigger_width = 360
          }
        }
      }
    '';
  };
}
