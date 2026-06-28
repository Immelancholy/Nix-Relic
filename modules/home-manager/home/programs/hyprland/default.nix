{
  pkgs,
  lib,
  ...
}:
{
  wayland.windowManager.hyprland = lib.mkMerge [
    {
      enable = true;
      package = null;
      portalPackage = null;
      xwayland.enable = false;
      systemd = {
        # disable the systemd integration, as it conflicts with uwsm.
        enable = false;
        variables = [ "--all" ];
      };
    }
  ];
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
  ];
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
    };
  };
}
