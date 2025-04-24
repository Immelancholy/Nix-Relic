{pkgs, ...}: {
  stylix = {
    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };
    enable = true;
    autoEnable = true;
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
        applications = 10;
        terminal = 10;
        desktop = 9;
        popups = 10;
      };
    };
  };
}
