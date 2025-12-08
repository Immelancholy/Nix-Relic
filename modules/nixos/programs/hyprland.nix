{
  config,
  lib,
  ...
}: let
  cfg = config.programs.hyprland;
in {
  config = lib.mkIf cfg.withUWSM {
    programs.uwsm.enable = lib.mkForce false;
    programs.nix-relic.uwsm.enable = true;
    programs.nix-relic.uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/start-hyprland";
        extraUWSMArgs = [
          "-e"
          "-D Hyprland"
        ];
      };
    };
  };
}
