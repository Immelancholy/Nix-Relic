{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.yazi;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      yazi = {
        enable = true;
      };
    };
  };
}
