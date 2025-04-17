{
  nixosConfig,
  lib,
  ...
}: {
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

  services.gnome-keyring = {
    enable = true;
    components = [
      "pkcs11"
      "secrets"
      "ssh"
    ];
  };

  xdg = {
    enable = true;
    configFile = {
      "autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
        source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
      };
      "vesktop/themes/mochaMauve.css".text = ''
        @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");
      '';
      "neo/colors".text = ''
        neo_color_version 1
        -1
        177
        141
        183
        153
        224
        225
      '';
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
  };

  home.stateVersion = "25.05";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
