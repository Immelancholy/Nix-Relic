{
  nixosConfig,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./programs
    ./themeing.nix
    ./zsh.nix
    ./env.nix
    ./mimeapps.nix
    ./stylix.nix
    ./oh-my-posh.nix
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
    "Pictures/wallpapers" = {
      source = ./backgrounds;
      recursive = true;
    };
  };

  home.stateVersion = "25.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
