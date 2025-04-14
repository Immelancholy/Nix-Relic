{
  pkgs,
  lib,
  ...
}: {
  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
    yazi = {
      enable = true;
      accent = "mauve";
      flavor = "mocha";
    };
    btop = {
      enable = true;
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
        set -g status-right-length 100
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_uptime}"
      '';
    };
    kitty = {
      enable = true;
    };
    cava = {
      enable = true;
      transparent = true;
    };
    lazygit = {
      enable = true;
    };
    obs = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
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
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Ice";
    # size = 20;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor = {
      enable = true;
      size = 22;
    };
  };

  home.file = {
    ".icons/bibata".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";
  };
  qt = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "Bibata-Modern-Ice";
      cursor-size = 22;
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty";
      # exec-arg = ""; # argument
    };
    "org/nemo/preferences" = {
      click-double-parent-folder = true;
      show-hidden-files = true;
      show-image-thumbnails = "always";
      thumbnail-limit = lib.hm.gvariant.mkUint64 104857600;
    };
    "org/nemo/preferences/menu-config" = {
      selection-menu-copy-to = true;
      selection-menu-move-to = true;
    };
    "org/nemo/search" = {
      search-reverse-sort = false;
      search-sort-column = "name";
    };
    "org/nemo/window-state" = {
      maximized = true;
      sidebar-bookmark-breakpoint = 5;
      sidebar-width = 141;
      start-with-menu-bar = false;
      start-with-sidebar = true;
      start-with-toolbar = true;
    };
  };
}
