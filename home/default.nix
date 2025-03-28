{
  nixosConfig,
  lib,
  user,
  scriptBin,
  ...
}: let
  scriptBinHome = lib.strings.removePrefix "/home/${user}/" "${scriptBin}";
in {
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

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

  home.file = {
    "Pictures/fastfetch_logos" = {
      source = ./programs/fastfetch/logo;
      recursive = true;
    };
    "Pictures/wallpapers" = {
      source = ./backgrounds;
      recursive = true;
    };
    ".zen/${user}.default" = {
      source = ./programs/zen;
      recursive = true;
    };
    "${scriptBinHome}" = {
      source = ./programs/scripts;
      recursive = true;
      executable = true;
    };
    ".zen/profiles.ini".text = ''
      [Profile0]
      Name=${user}Default
      IsRelative=1
      Path=${user}.default
      ZenAvatarPath=chrome://browser/content/zen-avatars/avatar-82.svg
      Default=1

      [General]
      StartWithLastProfile=1
      Version=2
    '';
  };

  xdg = {
    enable = true;
    configFile = {
      "autostart/input-mapper-autoload.desktop" = lib.mkIf nixosConfig.services.input-remapper.enable {
        source = "${nixosConfig.services.input-remapper.package}/share/applications/input-remapper-autoload.desktop";
      };
      # "discordcanary/settings.json".text = ''
      #   {
      #     "SKIP_HOST_UPDATE": true,
      #     "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
      #     "MIN_WIDTH": 940,
      #     "MIN_HEIGHT": 500,
      #     "openasar": {
      #       "setup": true,
      #       "noTyping": true,
      #       "css": "@import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");"
      #     },
      #     "BACKGROUND_COLOR": "#121214",
      #     "chromiumSwitches": {},
      #     "IS_MAXIMIZED": false,
      #     "IS_MINIMIZED": false,
      #     "WINDOW_BOUNDS": {
      #       "x": 10,
      #       "y": 40,
      #       "width": 1900,
      #       "height": 1030
      #     },
      #     "trayBalloonShown": true
      #   }
      # '';
    };
  };

  home.stateVersion = "24.11";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
