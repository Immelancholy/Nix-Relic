{lib, ...}: {
  nixpkgs.overlays = lib.mkForce null;
  stylix = {
    targets = {
      dunst.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      nixvim = {
        plugin = "base16-nvim";
        transparentBackground = {
          main = true;
          signColumn = true;
          numberLine = true;
        };
      };
      cava.rainbow.enable = true;
    };
  };
}
