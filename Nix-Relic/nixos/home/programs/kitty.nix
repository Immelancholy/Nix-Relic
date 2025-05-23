{config, ...}: let
  user = config.home.username;
in {
  programs.kitty = {
    enable = false;
    shellIntegration.enableZshIntegration = true;
    settings = {
      window_padding_width = 5;
      allow_remote_control = true;
      listen_on = "unix:/tmp/mykitty-${user}";
    };
    extraConfig = ''
      # background_opacity 0.67
      background_opacity 0.80
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
  # xdg.configFile."kitty/mpd.session".text = ''
  #   layout splits
  #   launch --title "inori" inori
  #   launch --location=vsplit --title "artis" artis
  #   resize_window short 8
  # '';
}
