{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    font = "JetBrainsMono Nerd Font Mono 12";
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "kitty";
  };
  imports = [
    ./theme.nix
  ];
}
