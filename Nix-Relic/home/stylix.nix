{
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "Caskaydia Cove Nerd Font Mono";
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
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        terminal = 10;
        desktop = 11;
        popups = 10;
      };
    };
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
    image = ./backgrounds/Neon-Beast-Girl.png;
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
