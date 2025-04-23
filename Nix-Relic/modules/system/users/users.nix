{
  pkgs,
  config,
  lib,
  inputs,
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
    programs.weylus.users = cfg.users;
    users.users = let
      users = cfg.users;
    in
      builtins.listToAttrs (map (user:
        lib.nameValuePair user {
          isNormalUser = true;
          extraGroups = ["networkmanager" "video" "seat"];
          description = "Account for ${user}";
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
          imports = [
            ../../../nixos/home
            # inputs.stylix.homeManagerModules.stylix
            ../../home
            inputs.catppuccin.homeModules.catppuccin
            inputs.nixvim.homeManagerModules.nixvim
            inputs.spicetify-nix.homeManagerModules.default
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
        })
      users);
  };
}
