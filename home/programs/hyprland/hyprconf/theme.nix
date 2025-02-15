{
  wayland.windowManager.hyprland.extraConfig = ''
    general {
      gaps_in = 3
      gaps_out = 8
      border_size = 2
      col.active_border = rgba(cba6f7ff) rgba(f5e0dcff) 45deg
      col.inactive_border = rgba(b4befecc) rgba(6c7086cc) 45deg
      layout = dwindle
      resize_on_border = true
    }
    group {
        col.border_active = rgba(cba6f7ff) rgba(f5e0dcff) 45deg
        col.border_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
        col.border_locked_active = rgba(cba6f7ff) rgba(f5e0dcff) 45deg
        col.border_locked_inactive = rgba(b4befecc) rgba(6c7086cc) 45deg
    }

    decoration {
        rounding = 10
        shadow:enabled = false

        blur {
            enabled = yes
            size = 6
            passes = 3
            new_optimizations = on
            ignore_opacity = on
            xray = false
        }
    }

    layerrule = blur,waybar

    decoration {
        dim_special = 0.3
        blur {
            special = true
        }
    }
  '';
}
