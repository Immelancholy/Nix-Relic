{
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    extraConfig = {
      display-drun = "Apps:";
      display-window = "Windows:";
      drun-display-format = "{icon} {name}";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
      modi = [
        "drun"
        "window"
        "filebrowser"
        "run"
      ];
    };
  };
  imports = [
    ./theme.nix
  ];
}
