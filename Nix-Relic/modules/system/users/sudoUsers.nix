{
  pkgs,
  config,
  lib,
  inputs,
  globalHomeImports,
  ...
}:
with lib; let
  cfg = config.userAccounts;
in {
  options.userAccounts = {
    sudoUsers = mkOption {
      type = types.listOf types.str;
      default = [];
      example = ["mela"];
      description = "Define Users with sudo";
    };
  };
  config = {
    programs.weylus.users = cfg.users;
    users.users = let
      users = cfg.sudoUsers;
    in
      builtins.listToAttrs (map (user:
        lib.nameValuePair user {
          isNormalUser = true;
          description = "Account for ${user}";
          extraGroups = ["networkmanager" "wheel" "video" "seat"];
          shell = pkgs.zsh;
          initialPassword = "password";
        })
      users);
    home-manager.users = let
      users = cfg.sudoUsers;
    in
      builtins.listToAttrs (map (user:
        lib.nameValuePair user {
          home.username = "${user}";
          home.homeDirectory = "/home/${user}";
        })
      users);
  };
}
