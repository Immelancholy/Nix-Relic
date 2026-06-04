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
    home.packages = [
      pkgs.mpvpaper
    ];
    systemd.user.services.paper-change = {
      Unit = {
        Description = "Wallpaper Changer";
        PartOf = [ "graphical-session.target" ];
        Requires = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "/run/current-system/sw/bin/systemctl stop --user hyprpaper";
        Type = "simple";
        Slice = [ "session.slice" ];
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
