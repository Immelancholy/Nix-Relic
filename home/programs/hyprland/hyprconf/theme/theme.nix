{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 3;
      gaps_out = 8;
      border_size = 2;
      "col.active_border" = "rgba(cba6f7ff) rgba(89dcebff) rgba(f5e0dcff) 40deg";
      "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      resize_on_border = true;
    };
    group = {
      "col.border_active" = "rgba(cba6f7ff) rgba(89dcebff) rgba(f5e0dcff) 40deg";
      "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      "col.border_locked_active" = "rgba(cba6f7ff) rgba(89dcebff) rgba(f5e0dcff) 40deg";
      "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      groupbar = {
        font_size = 12;
        gradients = false;
        text_color = "rgba(cdd6f4ff)";
        "col.active" = "rgba(cba6f7ff)";
        "col.inactive" = "rgba(b4befecc)";
      };
    };

    decoration = {
      rounding = 20;
      shadow.enabled = false;

      blur = {
        enabled = true;
        size = 3;
        passes = 2;
        vibrancy = 0.5;
        new_optimizations = true;
        ignore_opacity = true;
        xray = false;
        special = true;
      };
    };

    layerrule = [
      "blur,waybar"
    ];

    decoration = {
      dim_special = 0.3;
    };
  };
}
