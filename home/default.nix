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
    ./theming.nix
    ./zsh.nix
    ./env.nix
    ./mimeapps.nix
  ];

  # Packages that should be installed to the user profile.
  xdg.enable = true;

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

  fonts.fontconfig = {
    enable = true;
  };
  xdg.configFile."autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
    source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
  };

  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
