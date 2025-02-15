{ pkgs, ... }: {

  gtk = {
    enable = true;
    
    cursorTheme.package = pkgs.bibata-cursors;
    cursorTheme.name = "Bibata-Modern-Ice";
    cursorTheme.size = 20;

    iconTheme.package = pkgs.catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    };
    iconTheme.name = "Papirus-Dark";
  };

  home.file = {
    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  qt.enable = true;
  qt.platformTheme.name = "kvantum";
  qt.style.name = "kvantum";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
