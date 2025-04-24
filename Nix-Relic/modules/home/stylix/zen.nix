{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.zen;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      zen = {
        enable = true;
      };
    };
  };
}
