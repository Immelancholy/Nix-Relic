{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic;
in {
  options.nix-relic = {
    hostHomeFolderStructure = mkEnableOption "Use a folder structure of /hosts/''${hostname}/''${name}/home.nix to configure home-manager. Also sets networking.hostName.";
    flakePath = mkOption {
      type = types.str;
      default = "";
      description = "Path to Nix-Relic config flake";
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
      }
    };
  };
  config = let
    makeHM = name: _user: let
      user = config.users.users.${name};
    in
      mkIf cfg.hostHomeFolderStructure {
        _module.args = {
          inherit host user;
        };

        imports = [
          ./hosts/${host}/users/${name}/home.nix
        ];
      };
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
    networking.hostName = "${host}";

    environment.sessionVariables = {
      FLAKE_PATH = "/home/mela/NixDots"; # path to flake.nix
    };
  };
}
