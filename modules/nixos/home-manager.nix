{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  config = let
    nixosConfig = config;
    makeHM = name: _user: let
      user = config.users.users.${name};
    in ({
      config,
      options,
      pkgs,
      ...
    }:
      recursiveUpdate {
        _module.args = {
          inherit nixosConfig user;
        };

        home.username = "${name}";
        home.homeDirectory = "/home/${name}";
      }
      user.home-config);
  in {
    home-manager.users = mapAttrs makeHM config.nix-relic.users.users;
  };
}
