{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.kitty;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      kitty = {
        enable = true;
      };
    };
  };
}
