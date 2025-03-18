{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 10";
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    extraConfig = {
      modi = [
        "drun"
        "run"
        "filebrowser"
      ];
      show-icons = true;
      display-drun = " APPS";
      display-run = "󰲌 RUN";
      display-filebrowser = " FILES";
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
