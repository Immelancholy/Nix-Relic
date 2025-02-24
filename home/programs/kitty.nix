{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false;
      font_family = "CaskaydiaCove Nerd Font Mono";
      font_size = 9.5;
      window_padding_width = 15;
      allow_remote_control = true;
      listen_on = "unix:/run/user/1000/mykitty";
    };
    extraConfig = ''
      background_opacity 0.8
      confirm_os_window_close 0
      placement_strategy top
      cursor_trail 10
      cursor_trail_start_threshold 0
      shell_integration no-cursor
      cursor_trail_decay 0.01 0.12
      cursor_shape block
      cursor_blink true
    '';
  };
}
