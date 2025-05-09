{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.userAccounts;
in {
  options.userAccounts = {
    users = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["mela"];
      description = "Define Users";
    };
  };
  config = {
    users.users = let
      users = cfg.users;
    in
      builtins.listToAttrs (map (user:
        lib.nameValuePair user {
          isNormalUser = true;
          description = "Account for ${user}";
          extraGroups = ["networkmanager" "video" "seat"];
          shell = pkgs.zsh;
          initialPassword = "password";
        })
      users);
    home-manager.users = let
      users = cfg.users;
    in
      builtins.listToAttrs (map (user:
        lib.nameValuePair user {
          home.username = "${user}";
          home.homeDirectory = "/home/${user}";
        })
      users);
  };
}
