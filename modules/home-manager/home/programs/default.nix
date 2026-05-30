{
  pkgs,
  inputs,
  config,
  ...
}: let
  user = config.home.username;
in {
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
    ./easyeffects
    ./tmux.nix
    ./spicetify.nix
    ./swayidle.nix
    ./rofi
    ./cliphist.nix
    ./dunst.nix
    ./swaylock.nix
    ./udiskie.nix
    ./mpv.nix
    ./zathura.nix
    ./kitty.nix
    ./quickshell
    ./hyprquickframe.nix
    inputs.nix-relic.inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = {
      enable = true;
    };
    enablePrivateDesktopEntry = true;
    profiles."${user}.Default".mods = [
      "642854b5-88b4-4c40-b256-e035532109df" #transparent
      "599a1599-e6ab-4749-ab22-de533860de2c" #pimp pip
      "a6335949-4465-4b71-926c-4a52d34bc9c0" #better find bar
      "906c6915-5677-48ff-9bfc-096a02a72379" #floating status
    ];
  };

  programs.zed-editor = {
    enable = true;
    mutableUserTasks = true;
    mutableUserKeymaps = true;
    mutableUserSettings = true;
  };

  programs.satty = {
    enable = true;
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
