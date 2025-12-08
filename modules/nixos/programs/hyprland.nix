{
  config,
  lib,
  ...
}: let
  cfg = config.programs.hyprland;
in {
  config = lib.mkIf cfg.withUWSM {
    programs.uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/start-hyprland";
        extraUWSMArgs = [
          "-D Hyprland"
        ];
      };
    };
  };
}
