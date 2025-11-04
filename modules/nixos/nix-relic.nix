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
      default = "/etc/nixos";
      description = "Path to Nix-Relic config flake folder";
    };
    updateScript.enableToken = mkEnableOption "Use gh token to update flake";
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
    icons = {
      colour = mkOption {
        type = types.str;
        default = "";
        description = "Colour to use for tela circle icon theme";
      };
    };
  };
  config = {
    environment.sessionVariables = {
      FLAKE_PATH = "${cfg.flakePath}"; # path to flake.nix
    };
  };
}
