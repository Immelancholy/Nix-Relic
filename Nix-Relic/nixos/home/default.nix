{
  nixosConfig,
  lib,
  config,
  pkgs,
  ...
}: let
  user = config.home.username;
  Nakari = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GcHyQ8DWUAAOAho?format=jpg&name=medium";
    hash = "sha256-YB13taH2jBB6POHniL/muHxCT1Mpir40YgjCkU5Vetc=";
  };

  Goth_Chell = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GXERYazW0AErHbS?format=jpg&name=medium";
    hash = "sha256-OX8v3Xh+sDhgVv6P3leWHHZrIPiVuBrnd9iAoEPtFBQ=";
  };

  Azurenti = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GS9F_-JWMAALb1S?format=jpg&name=medium";
    hash = "sha256-+IdQuGYwOTUwS/B7tMpDf91o3uerAWaXSs4Wn5/jABU=";
  };

  Fubuki = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GJDueQOXsAA7DjN?format=jpg&name=medium";
    hash = "sha256-m7175RBqjgsDb+yNyRkR0AnVp9rvG1nrX7HKpqSJLSU=";
  };

  Shorea = pkgs.fetchurl {
    url = "https://pbs.twimg.com/media/GG0t0K6bcAA8-xW?format=jpg&name=medium";
    hash = "sha256-NJNpjZUxK+6vvOUJMt/NxkaSA1fUqee7czH+z2f/SU4=";
  };
in {
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
    ./themeing.nix
    ./zsh.nix
    ./env.nix
    ./mimeapps.nix
    ./stylix.nix
    ./activationScripts
  ];

  xdg = {
    enable = true;
    userDirs.enable = true;
    configFile = {
      "autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
        source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
      };
    };
  };
  home.file = {
    ".vimium/Vimium-C-Binds.json".text = ''
      {
        "name": "Vimium C",
        "@time": "14/04/2025, 12:38:22",
        "time": 1744630702689,
        "environment": {
          "extension": "1.99.997",
          "platform": "linux",
          "firefox": 137
        },
        "keyLayout": 2,
        "keyMappings": [
          "#!no-check",
          "unmap t",
          "map J nextTab",
          "map K previousTab",
          ""
        ],
        "vimSync": true
      }
    '';
    "Pictures/fastfetch_logos/Nakari.jpg" = {
      source = Nakari;
    };
    "Pictures/fastfetch_logos/Goth_Chell.jpg" = {
      source = Goth_Chell;
    };
    "Pictures/fastfetch_logos/Azurenti.jpg" = {
      source = Azurenti;
    };
    "Pictures/fastfetch_logos/Fubuki.jpg" = {
      source = Fubuki;
    };
    "Pictures/fastfetch_logos/Shorea.jpg" = {
      source = Shorea;
    };
    "Pictures/wallpapers" = {
      source = ./backgrounds;
      recursive = true;
    };
  };

  home.stateVersion = "25.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
