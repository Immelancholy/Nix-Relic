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
            trigger_width = 700

            trigger_height = 400
          }
        }
      }
    '';
  };
}
