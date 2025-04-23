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
      # package = pkgs.catppuccin-papirus-folders.override {
      #   flavor = "mocha";
      #   accent = "mauve";
      # };
      # dark = "Papirus-Dark";
      # light = "Papirus-Dark";
    };
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      tmux.enable = false;
      yazi.enable = false;
      nixvim.enable = false;
      btop.enable = false;
      spicetify.enable = false;
      kitty.enable = false;
      gtk.flatpakSupport.enable = true;
    };
  };
}
