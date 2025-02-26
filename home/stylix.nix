{pkgs, ...}: {
  stylix = {
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      tmux.enable = false;
      swaylock.enable = false;
      yazi.enable = false;
      nixvim.enable = false;
    };
  };
}
