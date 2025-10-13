{pkgs, ...}: {
  home.shell = {
    enableZshIntegration = true;
  };
  imports = [
    ./hyprland
    ./waybar
    ./yazi.nix
    ./mpd
    ./cava
    ./fastfetch
    ./nvim
    ./easyeffects
    ./tmux.nix
    ./spicetify.nix
    ./swayidle.nix
    ./obs.nix
    ./rofi
    ./cliphist.nix
    ./dunst.nix
    ./swaylock.nix
    ./udiskie.nix
    ./mpv.nix
    ./zathura.nix
    ./kitty.nix
    ./quickshell
  ];

  programs.zen = {
    enable = true;
    defaultBrowser = true;
  };

  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = false;
      };
    };
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      cudaSupport = true;
    };
    settings = {
      vim_keys = true;
      theme_background = false;
    };
  };

  services.mpris-proxy = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    options = [
      "--no-cmd"
    ];
  };
}
