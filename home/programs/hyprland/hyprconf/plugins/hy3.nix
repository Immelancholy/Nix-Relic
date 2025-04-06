{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland.useHy3 = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''Use Hy3 tyling style'';
    };
  };
  config = mkIf cfg.useHy3.enable {
    plugins = [
      inputs.hy3.packages.${pkgs.system}.hy3
    ];
    settings = {
      general = {
        layout = "hy3";
      };
    };
    extraConfig = ''
      plugin {
        hy3 {
          tabs {
            radius = 10
            padding = 4
            text_font = JetBrainsMono Nerd Font Mono Bold # default: Sans
            text_height = 9
            border_width = 2
            col.active = rgba(1e1e2eB5)
            col.active.border = rgba(cba6f7ff)
            col.active.text = rgba(cdd6f4ff)
            col.focused = rgba(1e1e2eB5)
            col.focused.border = rgba(6c7086cc)
            col.focused.text = rgba(7f849cff)
            col.inactive = rgba(1e1e2eB5)
            col.inactive.border = rgba(b4befecc)
            col.inactive.text = rgba(cdd6f4ff)
            col.urgent = rgba(1e1e2eB5)
            col.urgent.border = rgba(f9e2afff)
            col.urgent.text = rgba(cdd6f4ff)
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
