{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.stylix.targets.tmux;
in {
  config = mkIf (!cfg.enable) {
    catppuccin = {
      tmux = {
        enable = true;
      };
    };
  };
}
