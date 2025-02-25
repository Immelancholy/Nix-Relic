{
  inputs,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = inputs.wezterm.packages.${pkgs.system}.default;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      local config = wezterm.config_builder()

      config.color_scheme = 'catppuccin-mocha'

      config.font = wezterm.font ({
        family = 'CaskaydiaCove Nerd Font Mono',
        weight = 'Bold',
      })

      config.font_size = 10

      config.enable_tab_bar = false

      config.window_background_opacity = 0.8

      config.enable_kitty_graphics = true

      return config
    '';
  };
}
