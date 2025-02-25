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

      config.color_scheme = 'Catppuccin Mocha (Gogh)'

      config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")
      config.font_size = 9

      config.enable_tab_bar = false

      config.window_background_opacity = 0.8

      return config
    '';
  };
}
