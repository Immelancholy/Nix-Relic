{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    liveWallpaper.enable = mkEnableOption "Use animated wallpaper";
    liveWallpaper.path = mkOption {
      type = types.path;
      default = null;
      description = "Path to animated background";
    };
  };
  config = mkIf cfg.liveWallpaper.enable {
    home.packages = with pkgs; [
      mpvpaper
    ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        ''uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto" '*' ${config.wayland.windowManager.hyprland.liveWallpaper.path}''
      ];
    };
  };
}
