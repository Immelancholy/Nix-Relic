{ config, lib, ... }:
let
  user = config.home.username;
in
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      window_padding_width = 5;
      allow_remote_control = true;
      listen_on = "unix:/tmp/mykitty-${user}";
      background_opacity = lib.mkForce "0.85";
      confirm_os_window_close = 0;
      placement_strategy = "center";
      resize_in_steps = "yes";
      cursor_trail = 10;
      cursor_trail_start_threshold = 0;
      shellIntegration = "no-cursor";
      cursor_trail_decay = "0.01 0.15";
      cursor_shape = "beam";
      cursor_blink_interval = "0.5 ease-in-out";
    };
  };
}
