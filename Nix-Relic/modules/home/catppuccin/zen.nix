{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.catppuccin.zen;
  user = config.home.username;
in {
  options.catppuccin.zen = {
    enable = mkOption {
      type = types.bool;
      default = config.catppuccin.enable;
      description = "enable catppuccin zen theme";
    };
  };

  config = mkIf (cfg.enable && config.programs.zen.enable) {
    home.file = {
      ".zen/${user}.Default/chrome/userChrome.css" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userChrome.css";
      };
      ".zen/${user}.Default/chrome/userContent.css" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userContent.css";
      };
      ".zen/${user}.Default/chrome/zen-logo-mocha.svg" = {
        source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/zen-logo-mocha.svg";
      };
    };
  };
}
