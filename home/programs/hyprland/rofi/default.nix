{
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland-unwrapped;
    terminal = "kitty";
    font = "JetBrainsMono";
    plugins = with pkgs; [
      rofi-obsidian
      rofi-mpd
    ];
  };
  home.file.".local/share/rofi/themes/mytheme.rasi".text = ''

  '';
}
