{
  osConfig,
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  flake = [
    "${inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix}/lib/libcsgo-vulkan-fix.so, plugin, allow"
    "${inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers}/lib/libxtra-dispatchers.so, plugin, allow"
  ];
  noFlake = [
    "${pkgs.hyprlandPlugins.csgo-vulkan-fix}/lib/libcsgo-vulkan-fix.so, plugin, allow"
  ];
  cfg = config.wayland.windowManager.hyprland;
in {
  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      "$scr" = "$XDG_BIN_HOME";
      "$term" = "uwsm app -- ghostty";
      "$files" = "uwsm app -- nemo.desktop";
      "$filest" = "uwsm app -- yazi.desktop";
      "$mod" = "SUPER";
      "$mods" = "SUPERSHIFT";
      "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'';
      "$browser" = "uwsm app -- zen.desktop";
      "$edit" = "uwsm app -- nvim.desktop";
      "$playerctl" = "uwsm app -- playerctl --player=$player";
      "$discord" = "uwsm app -- vesktop.desktop";
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        key_press_enables_dpms = true;
      };
      cursor = {
        hide_on_key_press = true;
      };
      ecosystem = {
        # enforce_permissions = true;
      };
      permission =
        if cfg.usingFlake
        then
          [
            "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
            "${lib.getExe pkgs.grim}, screencopy, allow"
          ]
          ++ flake
        else
          [
            "${osConfig.programs.hyprland.portalPackage}/libexec/.xdg-desktop-portal-hyprland-wrapped, screencopy, allow"
            "${lib.getExe pkgs.grim}, screencopy, allow"
          ]
          ++ noFlake;
    };
  };
  imports = [
    ./binds.nix
    ./theme
    ./execs.nix
    ./windowrules.nix
  ];
}
