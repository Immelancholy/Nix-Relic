{
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    xwayland.enable = false;
    systemd = {
      # disable the systemd integration, as it conflicts with uwsm.
      enable = false;
      variables = ["--all"];
    };
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
      inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
    ];
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
