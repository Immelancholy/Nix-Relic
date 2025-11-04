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
    hyprtasking.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use Hyprtasking'';
    };
  };
  config = mkIf cfg.hyprtasking.enable {
    wayland.windowManager.hyprland = mkMerge [
      (mkIf cfg.usingFlake {
        settings = {
          bind = [
            "$mod, Space, hyprtasking:toggle, cursor"
          ];
          extraconfig = ''
            bind = $mod, Space, submap:hyprtasking
            submap = hyprtasking
            bind = , H, hyprtasking:move, left
            bind = , J, hyprtasking:move, down
            bind = , K, hyprtasking:move, up
            bind = , L, hyprtasking:move, right
            bind = , X, hyprtasking:killhovered
            bind = , Space, hyprtasking:toggle, cursor
            bind = , Escape, hyprtasking:toggle, cursor
            bind = , Space, submap, reset
            bind = , Escape, submap, reset
            submaps = reset
          '';

          plugin = {
            hyprtasking = {
              layout = "grid";
              gap_size = 4;
              border_size = 2;
              bg_color = "0x${config.lib.stylix.colors.base00})ff";

              gestures = {
                enabled = true;
                move_fingers = 3;
                move_distance = 300;
                open_fingers = 4;
                open_distance = 300;
                open_positive = true;
              };

              grid = {
                rows = 3;
                cols = 3;
                loop = true;
                gaps_use_aspect_ratio = false;
              };

              linear = {
                height = 400;
                scroll_speed = 1.0;
                blur = true;
              };
            };
          };
        };
        plugins = [
          nr.hyprtasking.packages.${pkgs.stdenv.hostPlatform.system}.hyprtasking
        ];
        settings.permission = [
          "${nr.hyprtasking.packages.${pkgs.stdenv.hostPlatform.system}.hyprtasking}/lib/libhyprexpo.so, plugin, allow"
        ];
      })
    ];
  };
}
