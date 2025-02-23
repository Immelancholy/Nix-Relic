{pkgs, ...}: {
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    # iconTheme.package = pkgs.catppuccin-papirus-folders.override {
    #   flavor = "mocha";
    #   accent = "mauve";
    # };
    # iconTheme.name = "Papirus-Dark";
    iconTheme.package = pkgs.tela-circle-icon-theme.override {
      colorVariants = [
        "dracula"
      ];
    };
    iconTheme.name = "Tela-Circle-Icon-Theme";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    hyprcursor.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 20;
  };

  home.file = {
    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 20;
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty --hold sh poke.sh";
      # exec-arg = ""; # argument
    };
  };
}
