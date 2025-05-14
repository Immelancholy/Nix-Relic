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
    "ColorPalette.nix".text = ''
      {
        base = "#${config.lib.stylix.colors.base00}";
        mantle = "#${config.lib.stylix.colors.base01}";
        surface0 = "#${config.lib.stylix.colors.base02}";
        surface1 = "#${config.lib.stylix.colors.base03}";
        surface2 = "#${config.lib.stylix.colors.base04}";
        text = "#${config.lib.stylix.colors.base05}";
        rosewater = "#${config.lib.stylix.colors.base06}";
        lavender = "#${config.lib.stylix.colors.base07}";
        red = "#${config.lib.stylix.colors.base08}";
        peach = "#${config.lib.stylix.colors.base09}";
        yellow = "#${config.lib.stylix.colors.base0A}";
        green = "#${config.lib.stylix.colors.base0B}";
        teal = "#${config.lib.stylix.colors.base0C}";
        blue = "#${config.lib.stylix.colors.base0D}";
        mauve = "#${config.lib.stylix.colors.base0E}";
        flamingo = "#${config.lib.stylix.colors.base0F}";
      }
    '';
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
