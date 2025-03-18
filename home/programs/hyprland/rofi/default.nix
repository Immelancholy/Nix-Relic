{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 10";
    package = pkgs.rofi-wayland;
    terminal = "kitty";
    extraConfig = {
      display-drun = " APPS";
      display-run = "󰲌 RUN";
      display-filebrowser = " FILES";
      window-format = "{w} · {c}";
      drun-display-format = "{name}";
      show-icons = true;
      icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
      modi = [
        "drun"
        "filebrowser"
        "run"
      ];
    };
  };
  imports = [
    ./theme.nix
  ];
}
