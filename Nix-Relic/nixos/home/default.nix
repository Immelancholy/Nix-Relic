{
  nixosConfig,
  lib,
  config,
  ...
}: let
  user = config.home.username;
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
    ".zen/profiles.ini".text = ''
      [Profile0]
      Name=${user}Default
      IsRelative=1
      Path=${user}.Default
      ZenAvatarPath=chrome://browser/content/zen-avatars/avatar-82.svg
      Default=1

      [General]
      StartWithLastProfile=1
      Version=2
    '';
    "Pictures/fastfetch_logos" = {
      source = ./programs/fastfetch/logo;
      recursive = true;
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
