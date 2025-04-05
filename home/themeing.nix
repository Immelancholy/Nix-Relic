{pkgs, ...}: {
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
      size = 20;
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
      cursor-size = 20;
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "kitty";
      # exec-arg = ""; # argument
    };
  };
}
