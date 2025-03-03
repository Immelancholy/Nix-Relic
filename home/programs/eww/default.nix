{pkgs, ...}: {
  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.eww-wayland;
    configDir = ./widgets;
  };
}
