{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_family = "CaskaydiaCove Nerd Font Mono";
      bold_font = "CaskaydiaCove Nerd Font Mono Bold";
      italic_font = "CaskaydiaCove Nerd Fonr Mono Italic";
      bold_italic_font = "CaskaydiaCove Nerd Font Mono Bold Italic";
      font_size = 10;
      window_padding_width = 5;
      allow_remote_control = true;
      listen_on = "unix:/run/user/1000/mykitty";
    };
    extraConfig = ''
      background_opacity 0.8
      confirm_os_window_close 0
      placement_strategy center
      resize_in_steps yes
      cursor_trail 10
      cursor_trail_start_threshold 0
      shell_integration no-cursor
      cursor_trail_decay 0.01 0.15
      cursor_shape beam
      cursor_blink_interval 0.5 ease-in-out
    '';
  };
}
