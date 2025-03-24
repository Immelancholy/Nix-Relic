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
          # no_gaps_when_only = 1
          group_inset = 4
          autotile {
            enable = true
            # ephemeral_groups = false
            trigger_width = 640
            trigger_height = -1
          }
        }
      }
    '';
  };
}
