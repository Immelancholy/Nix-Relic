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
          tabs {
            border_width = 2
            col.active = rgba(1e1e2eCC)
            col.active.border = rgba(cba6f7ff)
            col.inactive = rgba(1e1e2eCC)
            col.inactive.border = rgba(b4befeff)
            col.urgent = rgba (1e1e2eCC)
            col.urgent.border = rgba(f9e2afff)
          }
          # no_gaps_when_only = 1
          group_inset = 4
          autotile {
            enable = true
            ephemeral_groups = false
            trigger_width = 640
            trigger_height = 340
          }
        }
      }
    '';
  };
}
