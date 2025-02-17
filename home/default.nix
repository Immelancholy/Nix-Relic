{ pkgs, lib, ... }:

{
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
  xdg.portal = lib.mkDefault {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    configPackages = with pkgs; [xdg-desktop-portal-gtk ];
  };

  home.sessionVariables.GTK_THEME = "Catppuccin-mocha";
  
  xdg.configFile."xfce4/helpers.rc" = {
    source = ./helpers.rc;
  };
  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      exec = "kitty sh /home/mela/.local/share/bin/kitty_nvim.sh";
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

  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["nvim.desktop"];
    "inode/directory" = ["thunar.desktop"];
  };

  home.stateVersion = "24.11";
   # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
