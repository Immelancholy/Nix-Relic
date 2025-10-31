{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.wayland.windowManager.hyprland;
in {
  options.wayland.windowManager.hyprland = {
    usingFlake = mkEnableOption "Enable if you're using the flake";
  };
}
