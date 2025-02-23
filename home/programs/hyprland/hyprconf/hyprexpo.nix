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
        hyprexpo {
          columns = 3
          gap_size = 5
          bg_col = rgb(cba6f7)
          workspace_method = center current
        }
      }
    '';
  };
}
