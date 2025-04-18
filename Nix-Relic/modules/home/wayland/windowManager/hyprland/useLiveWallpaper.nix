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
    useLiveWallpaper = mkEnableOption "Use animated wallpaper";
  };
  config = mkIf cfg.useLiveWallpaper {
    home.packages = with pkgs; [
      mpvpaper
    ];
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        ''uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto" '*' $HOME/Pictures/wallpapers/Neon-Beast-Girl.mp4''
      ];
    };
  };
}
