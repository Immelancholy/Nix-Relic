{ pkgs, ... }: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    enableHidpi = true;
    theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 20;
      };
    };
  };
}
