{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "kitty";
  };
  imports = [
    ./theme.nix
  ];
}
