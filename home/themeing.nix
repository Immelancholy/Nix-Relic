{pkgs, ...}: {
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    yazi = {
      enable = true;
      accent = "mauve";
      flavor = "mocha";
    };
    gtk = {
      enable = true;
      accent = "mauve";
      flavor = "mocha";
    };
    btop = {
      enable = true;
      flavor = "mocha";
    };
    rofi = {
      enable = false;
      flavor = "mocha";
    };
    waybar.enable = false;
    dunst = {
      enable = false;
    };
    tmux = {
      enable = true;
      flavor = "mocha";
      extraConfig = ''
        set -g @catppuccin_window_status_style "rounded"
      '';
    };
  };

  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };

    iconTheme.package = pkgs.catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    };
    iconTheme.name = "Papirus-Dark";
    # iconTheme.package = pkgs.tela-circle-icon-theme.override {
    #   colorVariants = [
    #     "dracula"
    #   ];
    # };
    # iconTheme.name = "Tela-circle-dracula";
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
