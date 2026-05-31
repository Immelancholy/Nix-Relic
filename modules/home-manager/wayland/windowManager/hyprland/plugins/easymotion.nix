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
      extraConfig = let
        rgb = color: "rgb(${color})";
        rgba = color: alpha: "rgba(${color}${alpha})";
        colors = config.lib.stylix.colors;
      in
        with colors;
        /*
        Lua
        */
          ''
            hl.bind(mod .. " + I", hl.dsp.easymotion({ action = "hyprctl dispatch focuswindow", address = {} }))
            hl.config({
              plugin = {
                easymotion = {
                  textcolor = "${rgba base05 "ff"}",
                  bgcolor = "${rgba base00 "bb"}",
                  bordercolor = {colors = { "${rgb base0E}", "${rgb base0C}", "${rgb base06}" }, angle = 40 },
                  blur = 1,
                  textpadding = 8,
                  textsize = 35,
                  bordersize = 2,
                  fullscreen_action = "maximize"
                }
              }
            })
          '';
      plugins = [
        nr.hyprland-easymotion.packages.${pkgs.stdenv.hostPlatform.system}.hyprland-easymotion
      ];
    };
  };
}
