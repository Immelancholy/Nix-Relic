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
    cava = {
      framerate = mkOption {
        type = types.int;
        default = 60;
        description = "Cava's framerate";
      };
      noiseReduction = mkOption {
        type = types.int;
        default = 30;
        description = "Cava's noise reduction";
      };
    };
    framerates = {
      steamGamescopeSession = mkOption {
        type = types.int;
        default = 60;
        description = "Steam gamescope session's framerate";
      };
      neo = mkOption {
        type = types.int;
        default = 60;
        description = "Neo framerate";
      };
    };
  };
  config = {
    environment.sessionVariables = {
      FLAKE_PATH = "${cfg.flakePath}"; # path to flake.nix
    };
  };
}
