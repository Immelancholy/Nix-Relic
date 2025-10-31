{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic;
in {
  options.nix-relic = {
    flakePath = mkOption {
      type = types.path;
      default = "";
      description = "Path to Nix-Relic config flake folder";
    };
    framerates = {
      cava = mkOption {
        type = types.int;
        default = 60;
        description = "Cava's framerate";
      };
      steamGamescopeSession = mkOption {
        type = types.int;
        default = 60;
        description = "Steam gamescope session's framerate";
      };
    };
  };
  config = {
    environment.sessionVariables = {
      FLAKE_PATH = "${cfg.flakePath}"; # path to flake.nix
    };
  };
}
