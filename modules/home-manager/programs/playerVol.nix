{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.player;
  playerVolMPD = pkgs.callPackage ../../../packages/playerVolMPD.nix {inherit system;};
  playerVolMpris = pkgs.callPackage ../../../packages/playerVolMpris.nix {inherit system;};
  playerVolDefault_Sink = pkgs.callPackage ../../../packages/playerVolDefault_Sink.nix {inherit system;};
in {
  options.player = {
    enable = mkEnableOption "Enable playerVol script";
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
    scriptUseDefaultSink = mkOption {
      type = types.bool;
      default = false;
      description = "Make the volume control script use the default sink";
    };
  };
  config = mkMerge [
    (mkIf (config.wayland.windowManager.hyprland.enable && cfg.enable) {
      wayland.windowManager.hyprland.settings = {
        "$player" = "${cfg.name}";
        exec-once = [
          ''[workspace 1 silent; float; size 888 559; move 610 42] ${cfg.cmd}''
        ];
        bind = [
          ''$mods, U, exec, [workspace 1 silent; float; size 888 559; move 610 42] ${cfg.cmd}''
        ];
      };
    })
    (mkIf (cfg.enable && config.player.name == "mpd" && ! config.player.scriptUseDefaultSink) {
      home.packages = [
        playerVolMPD
      ];
    })
    (mkIf (cfg.enable && config.player.name != "mpd" && ! config.player.scriptUseDefaultSink) {
      home.packages = [
        (playerVolMpris.override {
          player = cfg.name;
        })
      ];
    })
    (mkIf (cfg.enable && config.player.scriptUseDefaultSink) {
      home.packages = [
        playerVolDefault_Sink
      ];
    })
  ];
}
