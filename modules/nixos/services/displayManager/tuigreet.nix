{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.displayManager.tuiGreet;
in {
  options.displayManager.tuiGreet = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use TuiGreet as display manager'';
    };
  };
  config = mkIf cfg.enable {
    environment.sessionVariables = {
      DISPLAY_MANAGER = "tuiGreet";
    };
    security.pam.services.greetd.enableGnomeKeyring = true;
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r";
          user = "greeter";
        };
      };
    };
  };
}
