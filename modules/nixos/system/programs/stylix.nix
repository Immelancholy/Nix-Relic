{
  pkgs,
  inputs,
  config,
  nix-relic,
  ...
}: let
  colour = config.nix-relic.icons.colour;
  cfg = config.nix-relic;
in {
  imports = [
    inputs.nix-relic.inputs.stylix.nixosModules.stylix
  ];
  nix-relic.icons =
    if
      cfg.path
      == "${nix-relic}/backgrounds/Sailor_Moon.png"
      || cfg.path == "${nix-relic}/backgrounds/Surtur.png"
    then {
      colour = "red";
    }
    else if
      cfg.path
      == "${nix-relic}/backgrounds/Momo_Smoke.png"
      || cfg.path
      == "${nix-relic}/backgrounds/Evil_Miku.png"
    then {
      colour = "dracula";
    }
    else {
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
    stylix.icons = {
      enable = true;
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [
          "${colour}"
        ];
      };
      dark = "Tela-circle-${colour}";
      light = "Tela-circle-${colour}";
    };
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
