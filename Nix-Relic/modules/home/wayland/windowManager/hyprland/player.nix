{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    player.cmd = mkOption {
      type = types.str;
      default = ''uwsm app -- kitty --class "mpd" --session=mpd.session'';
      description = "Launch command for music player";
    };
    player.class = mkOption {
      type = types.str;
      default = ''mpd'';
      description = "Class of music player";
    };
  };
  config = {
    wayland.windowManager.hyprland.settings = {
      exec-once = [
        ''[workspace 1 silent; float; size 858 559; move 640 40] ${cfg.player.cmd}''
      ];
      bind = [
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] ${cfg.player.cmd}''
      ];
    };
  };
}
