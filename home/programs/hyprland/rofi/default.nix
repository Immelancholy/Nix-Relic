{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono";
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "kitty";
  };
  imports = [
    ./theme.nix
  ];
}
