{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  cfg = config.wayland.windowManager.hyprland;
in
{
  options.wayland.windowManager.hyprland = {
    liveWallpaper.enable = mkOption {
      type = types.bool;
      default = osConfig.nix-relic.wallpaper.animatedWallpaper.enable;
      description = "Use animated wallpaper";
    };
    liveWallpaper.path = mkOption {
      type = types.path;
      default = osConfig.nix-relic.wallpaper.animatedWallpaper.path;
      description = "Path to animated background";
    };
  };
  config = mkIf (cfg.liveWallpaper.enable && cfg.enable) {
    home.packages = with pkgs; [
      mpvpaper
    ];
  };
}
