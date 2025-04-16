{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        enable_posix_regex = true;
        frame_color = "#cba6f7c0";
        separator_color = "frame";
        highlight = "#89b4fac0";
        gaps_size = 4;
        frame_width = 2;
        corner_radius = 18;
        origin = "top-right";
        offset = "(54, 18)";
        width = "(0, 280)";
        height = "(0, 330)";
        alignment = "center";
        icon_corner_radius = 15;
        icon_position = "top";
        padding = 13;
        horizontal_padding = 10;
        max_icon_size = 256;
        font = "JetBrainsMono Nerd Font Mono 9";
      };
      urgency_low = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e99";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8c0";
      };
    };
  };
}
