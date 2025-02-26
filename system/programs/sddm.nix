{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    enableHidpi = true;
    #theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    theme = "hyprland_kath";
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 20;
      };
    };
  };
}
