{
  pkgs,
  inputs,
  config,
  ...
}: {
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
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    defaultBrowser = {
      enable = true;
      desktopFile = "zen-beta.desktop";
    };
  };

  programs.satty = {
    enable = true;
    package = pkgs.nrm.satty;
    settings = {
      general = {
        fullscreen = false;
        disable-notifications = true;
        early-exit = false;
        corner-roundness = 12;
        initial-tool = "brush";
        copy-command = "wl-copy";
        annotation-size-factor = 2;
        default-fill-shapes = false;
        output-filename = "$XDG_SCREENSHOTS_DIR/screenshot-%Y-%m-%d_%H:%M:%S.png";
        save-after-copy = false;
        default-hide-toolbars = false;
        focus-toggles-toolbars = true;
        primary-highlighter = "block";
        actions-on-enter = [
          "save-to-clipboard"
        ];
        actions-on-escape = [
          "exit"
        ];
        action-on-enter = "save-to-clipboard";
        right-click-copy = false;
        no-window-decoration = true;
        brush-smooth-history-size = 10;
      };
      keybinds = {
        pointer = "p";
        crop = "c";
        brush = "b";
        line = "i";
        arrow = "z";
        rectangle = "r";
        ellipse = "e";
        text = "t";
        marker = "m";
        blur = "u";
        highlight = "g";
      };
    };
  };

  home.packages = [
    (inputs.hyprquickshot.packages.${pkgs.system}.default.override {
      SattyPackage = config.programs.satty.package;
    })
  ];

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
