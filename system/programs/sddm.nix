{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    enableHidpi = true;
    #theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    theme = "${pkgs.sddm-astronaut}";
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 20;
      };
    };
  };
}
