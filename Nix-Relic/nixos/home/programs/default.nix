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
    ./kitty.nix
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
    ./ghostty.nix
  ];

  programs.zen = {
    enable = true;
    defaultBrowser = true;
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
