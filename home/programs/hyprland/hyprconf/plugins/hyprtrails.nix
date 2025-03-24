{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
    extraConfig = ''
      plugin {
        hyprtrails {
          color = rgba(cba6f7ff)
        }
      }
    '';
  };
}
