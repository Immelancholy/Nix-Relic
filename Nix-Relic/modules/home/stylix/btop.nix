{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.btop;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      btop = {
        enable = true;
      };
    };
  };
}
