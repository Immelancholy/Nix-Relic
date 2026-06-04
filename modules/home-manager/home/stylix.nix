{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:
let
  iconColour = osConfig.nix-relic.icons.colour;
in
{
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
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
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      hyprland.enable = false;
      nixvim = {
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
          numberLine = true;
        };
      };
      cava.rainbow.enable = true;
      zen-browser = {
        profileNames = [
          "${config.home.username}.Default"
        ];
        opacity = {
          enable = true;
          override.applications = 0.5;
        };
      };
    };
  };
}
