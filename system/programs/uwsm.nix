{pkgs, ...}: {
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprgame = {
          prettyName = "Hyprland (GameMode)";
          comment = "Barebones config to go with steamdeck mode";
          binPath = "Hyprland --config /home/mela/hyprcord.config";
        };
      };
    };
  };
}
