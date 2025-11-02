{
  pkgs,
  inputs,
  config,
  nix-relic,
  ...
}: let
  image = config.nix-relic.wallpaper.path;
in {
  imports = [
    inputs.nix-relic.inputs.stylix.nixosModules.stylix
  ];
  nix-relic.icons =
    if "${image}" == "${nix-relic}/backgrounds/Sailor_Moon.png"
    then {
      colour = "red";
    }
    else if "${image}" == "${nix-relic}/backgrounds/Evil_Miku.png"
    then {
      colour = "dracula";
    }
    else if "${image}" == "${nix-relic}/backgrounds/Surtur.png"
    then {
      colour = "orange";
    }
    else {
      colour = "dracula";
    };
  stylix = {
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    enable = true;
    autoEnable = true;
    # targets.console.enable = false;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    targets.nixos-icons.enable = true;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
      };
      serif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Serif Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.noto;
        name = "Noto Sans Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 10;
        terminal = 10;
        desktop = 9;
        popups = 10;
      };
    };
  };
}
