{
  pkgs,
  inputs,
  config,
  nix-relic,
  ...
}:
let
  image = config.nix-relic.wallpaper.path;
  iconColour = config.nix-relic.icons.colour;
in
{
  imports = [
    inputs.nix-relic.inputs.stylix.nixosModules.stylix
  ];
  nix-relic.icons =
    if "${image}" == "${nix-relic}/backgrounds/Sailor_Moon.png" then
      {
        colour = "red";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Evil_Miku.png" then
      {
        colour = "dracula";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Surtur.png" then
      {
        colour = "orange";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Momo_Smoke.png" then
      {
        colour = "blue";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Smoke_In_Rain.png" then
      {
        colour = "purple";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Cyberpunk.png" then
      {
        colour = "yellow";
      }
    else if "${image}" == "${nix-relic}/backgrounds/Cyberpunk_Rain.png" then
      {
        colour = "purple";
      }
    else
      {
        colour = "standard";
      };
  stylix = {
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    enable = true;
    icons = {
      enable = true;
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [
          "${iconColour}"
        ];
      };
      dark = "Tela-circle-${iconColour}";
      light = "Tela-circle-${iconColour}";
    };
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
        name = "FiraCode Nerd Font Mono";
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
