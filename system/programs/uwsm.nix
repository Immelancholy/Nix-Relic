{pkgs, ...}: {
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprgame = {
          prettyName = "Hyprland (GameMode)";
          comment = "Barebones config to go with steamdeck mode";
          binPath = "/run/current-system/sw/bin/Hyprland -c /home/mela/hyprcord.config";
        };
      };
    };
  };
}
