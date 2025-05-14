{
  pkgs,
  lib,
  config,
  ...
}: {
  catppuccin = {
    tmux = {
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
    obs = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
  };

  home.pointerCursor = {
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Ice";
    # size = 20;
    gtk.enable = true;
    x11.enable = true;
    hyprcursor = {
      enable = true;
      size = config.stylix.cursor.size;
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
      cursor-theme = config.stylix.cursor.name;
      cursor-size = config.stylix.cursor.size;
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty";
      # exec-arg = ""; # argument
    };
    "org/nemo/preferences" = {
      click-double-parent-folder = true;
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
    "com/github/wwmm/easyeffects/spectrum" = {
      rounded-corners = true;
    };
  };
}
