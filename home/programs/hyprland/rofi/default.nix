{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    extraConfig = {
      # hover-select = true;
      # me-select-entry = "";
      # me-accept-entry = "MousePrimary";
      modi = [
        "drun"
        "run"
        "filebrowser"
        "window"
      ];
      show-icons = true;
      display-drun = "";
      display-run = "󰲌";
      display-filebrowser = "";
      display-window = "";
      drun-display-format = "{name}";
      window-format = "{w} · {c}";
      icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
    };
  };
  imports = [
    ./theme.nix
  ];
}
