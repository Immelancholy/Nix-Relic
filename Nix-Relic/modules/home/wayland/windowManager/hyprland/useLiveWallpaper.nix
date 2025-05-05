{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;

  paper-change = pkgs.writeShellScriptBin "paper-change" ''
    if command -v mpvpaper
    then
      pkill mpvpaper
      uwsm app -- mpvpaper -f -p -o "--loop hwdec=auto --no-audio" '*' ${cfg.liveWallpaper.path}
    else
      pkill mpvpaper
    fi
  '';
in {
  options.wayland.windowManager.hyprland = {
    liveWallpaper.enable = mkEnableOption "Use animated wallpaper";
    liveWallpaper.path = mkOption {
      type = types.path;
      default = null;
      description = "Path to animated background";
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = [
        paper-change
      ];
      systemd.user.services.paper-change = {
        Unit = {
          Description = "Wallpaper Changer";
          PartOf = ["graphical-session.target"];
          Requires = ["graphical-session.target"];
          After = ["graphical-session.target"];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
        Service = {
          ExecStart = ''/run/current-system/sw/bin/hyprctl dispatch exec paper-change'';
          Type = "simple";
          Slice = ["session.slice"];
          Restart = "on-failure";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    })
    (mkIf (cfg.liveWallpaper.enable && cfg.enable) {
      home.packages = with pkgs; [
        mpvpaper
      ];
    })
  ];
}
