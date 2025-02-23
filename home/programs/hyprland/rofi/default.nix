{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "kitty";
    font = "JetBrainsMono";
  };
  imports = [
    ./theme.nix
  ];
}
