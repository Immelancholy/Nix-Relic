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
          services.mpdris2.mpd.musicDirectory = "/home/${user}/Music";
          imports = [
            ../../../home
            inputs.stylix.homeManagerModules.stylix
            ../../home
            inputs.catppuccin.homeModules.catppuccin
            inputs.nixvim.homeManagerModules.nixvim
            inputs.spicetify-nix.homeManagerModules.default
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
          ];
          home.file = {
            "Pictures/fastfetch_logos" = {
              source = ../../../home/programs/fastfetch/logo;
              recursive = true;
            };
            "Pictures/wallpapers" = {
              source = ../../../home/backgrounds;
              recursive = true;
            };
            ".zen/${user}.Default/chrome/userChrome.css" = {
              source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userChrome.css";
            };
            ".zen/${user}.Default/chrome/userContent.css" = {
              source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/userContent.css";
            };
            ".zen/${user}.Default/chrome/zen-logo-mocha.svg" = {
              source = "${inputs.catppuccinZen}/themes/Mocha/Mauve/zen-logo-mocha.svg";
            };
            ".zen/profiles.ini".text = ''
              [Profile0]
              Name=${user}Default
              IsRelative=1
              Path=${user}.Default
              ZenAvatarPath=chrome://browser/content/zen-avatars/avatar-82.svg
              Default=1

              [General]
              StartWithLastProfile=1
              Version=2
            '';
          };
        })
      users);
  };
}
