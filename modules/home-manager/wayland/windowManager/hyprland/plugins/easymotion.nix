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
    easymotion.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Use easymotion'';
    };
  };
  config = mkIf (cfg.easymotion.enable
    && cfg.usingFlake) {
    wayland.windowManager.hyprland = {
      plugins = [
        nr.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion
      ];
      settings = {
        bind = [
          {
            _args = [
              (mkLuaInline "mod .. \" + I\"")
              (mkLuaInline "hl.dsp.easymotion({ action = \"hyprctl dispatch focuswindow\", address = {} })")
            ];
          }
        ];

        plugin = {
          easymotion = {
            textcolor = "rgba(${config.lib.stylix.colors.base05}ff)";
            bgcolor = "rgba(${config.lib.stylix.colors.base00}bb)";
            bordercolor = "rgba($mauveff) rgba($tealff) rgba($rosewaterff) 40deg";
            blur = 1;
            textpadding = 8;
            textsize = 35;
            bordersize = 2;
            fullscreen_action = "maximize";
          };
        };
      };
    };
  };
}
