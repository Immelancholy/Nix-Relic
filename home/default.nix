{
  pkgs,
  nixosConfig,
  lib,
  ...
}: {
  # TODO please change the username & home directory to your own
  home.username = "mela";
  home.homeDirectory = "/home/mela";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  imports = [
    ./programs
    ./qtk.nix
    ./zsh.nix
    ./env.nix
  ];

  # Packages that should be installed to the user profile.
  xdg.enable = true;
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
      enable = true;
      flavor = "mocha";
    };
    waybar.enable = false;
    dunst = {
      enable = false;
    };
  };

  programs.mpv = {
    enable = true;

    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };

  home.sessionVariables.GTK_THEME = "Catppuccin-mocha";

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "kitty sh /home/mela/.local/share/bin/nv.sh";
      type = "Application";
      terminal = false;
      categories = ["Utility" "TextEditor"];
      icon = "nvim";
      mimeType = ["text/english" "text/plain" "text/x-makefile" "text/x-c++hdr" "text/x-c++src" "text/x-chdr" "text/x-csrc" "text/x-java" "text/x-moc" "text/x-pascal" "text/x-tcl" "text/x-tex" "application/x-shellscript" "text/x-c" "text/x-c++"];
    };
  };

  xdg.configFile."rmpc" = {
    source = ./programs/rmpc;
    recursive = true;
  };
  home.file = {
    ".local/share/bin" = {
      source = ./programs/scripts;
      recursive = true;
    };
  };
  home.file = {
    ".zen/yzyavqg4.default" = {
      source = ./programs/zen;
      recursive = true;
    };
  };
  home.file = {
    "Pictures/wallpapers" = {
      source = ./backgrounds;
      recursive = true;
    };
  };
  home.file = {
    "Pictures/fastfetch_logos" = {
      source = ./programs/fastfetch/logo;
      recursive = true;
    };
  };
  home.file = {
    "Pictures/screenshots" = {
      source = ./screenshots;
      recursive = true;
    };
  };

  fonts.fontconfig = {
    enable = true;
  };
  xdg.configFile."autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
    source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "text/plain" = ["nvim.desktop"];
      "text/html" = ["zen.desktop"];
      "text/css" = ["nvim.desktop"];
      "test/csv" = ["nvim.desktop"];
      "test/javascript" = ["nvim.desktop"];
      "application/json" = ["nvim.desktop"];
      "application.xml" = ["nvim.desktop"];
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["com.github.rafostar.Clapper.desktop"];
      "video/quicktime" = ["com.github.rafostar.Clapper.desktop"];
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "x-scheme-handler/about" = ["zen.desktop"];
      "x-scheme-handler/unknown" = ["zen.desktop"];
      "default-web-browser" = ["zen.desktop"];
    };
    defaultApplications = {
      "text/plain" = ["nvim.desktop"];
      "text/html" = ["zen.desktop"];
      "text/css" = ["nvim.desktop"];
      "test/csv" = ["nvim.desktop"];
      "test/javascript" = ["nvim.desktop"];
      "application/json" = ["nvim.desktop"];
      "application.xml" = ["nvim.desktop"];
      "inode/directory" = ["nemo.desktop"];
      "video/mp4" = ["com.github.rafostar.Clapper.desktop"];
      "video/quicktime" = ["com.github.rafostar.Clapper.desktop"];
      "x-scheme-handler/http" = ["zen.desktop"];
      "x-scheme-handler/https" = ["zen.desktop"];
      "x-scheme-handler/about" = ["zen.desktop"];
      "x-scheme-handler/unknown" = ["zen.desktop"];
      "default-web-browser" = ["zen.desktop"];
    };
  };

  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
