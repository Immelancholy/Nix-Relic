{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
      inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
    ];
    systemd = {
      # disable the systemd integration, as it conflicts with uwsm.
      enable = false;
      variables = ["--all"];
    };
  };
  services.hyprpolkitagent.enable = true;

  home.packages = with pkgs; [
    hyprpicker
    hyprshot
  ];

  imports = [
    ./hyprconf
  ];
}
