{ pkgs, inputs, ... }: {
  imports = [
    ./hyprconf
    ./rofi
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = ["--all"];
    # plugins = [
    #   inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    # ];
  };
  home.packages = with pkgs; [
    dunst
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    rofi-wayland
    inputs.swww.packages.${pkgs.system}.swww
    libnotify
    hypridle
    hyprpicker
    hyprland-qtutils
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    grim
    slurp
  ];
}
