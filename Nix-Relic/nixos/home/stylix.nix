{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
    iconTheme = {
      enable = true;
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [
          "dracula"
        ];
      };
      dark = "Tela-circle-dracula";
      light = "Tela-circle-dracula";
    };
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      nixvim = {
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
        };
      };
    };
  };
}
