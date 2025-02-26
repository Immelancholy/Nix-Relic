{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
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
      };
    };
  };
}
