{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
  nr = inputs.nix-relic.inputs;
in {
  options.wayland.windowManager.hyprland = {
    hycov.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use hycov'';
    };
  };
  config = mkIf (cfg.hycov.enable
    && cfg.usingFlake) {
    wayland.windowManager.hyprland = {
      plugins = [
        nr.hycov.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
      settings = {
        bind = [
          "Alt, Space, hycov:toggleoverview"
          "Alt, Left, hycov:movefocus l"
          "Alt, Right, hycov:movefocus r"
          "Alt, Rp, hycov:movefocus u"
          "Alt, Down, hycov:movefocus d"
        ];
      };
    };
  };
}
