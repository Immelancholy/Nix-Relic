{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.player;
in {
  options.player = {
    name = mkOption {
      type = types.str;
      default = "mpd";
      description = "Mpris name of the music player";
    };
    cmd = mkOption {
      type = types.str;
      default = ''uwsm app -- kitty --class "mpd" --session=mpd.session'';
      description = "Launch command for music player";
    };
    class = mkOption {
      type = types.str;
      default = ''mpd'';
      description = "Class of music player";
    };
  };
  config = {
    wayland.windowManager.hyprland.settings = {
      "$player" = "${cfg.name}";
      exec-once = [
        ''[workspace 1 silent; float; size 858 559; move 640 40] ${cfg.cmd}''
      ];
      bind = [
        ''$mods, U, exec, [workspace 1 silent; float; size 858 559; move 640 40] ${cfg.cmd}''
      ];
    };
  };
}
