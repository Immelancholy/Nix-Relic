{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      # hover-select = true;
      # me-select-entry = "";
      # me-accept-entry = "MousePrimary";
      modi = [
        "drun"
        "run"
        "filebrowser"
        "power-menu"
        # "window"
      ];
      show-icons = true;
      display-drun = " Apps";
      display-run = "󰲌 Run";
      display-filebrowser = " Files";
      # display-window = " Windows";
      drun-display-format = "{name}";
      window-format = "{w} · {c}";
      icon-theme = "Papirus-Dark";
      # icon-theme = "Tela-circle-dracula";
    };
  };
  home.packages = with pkgs; [
    rofi-power-menu
  ];
  imports = [
    ./theme.nix
  ];
}
