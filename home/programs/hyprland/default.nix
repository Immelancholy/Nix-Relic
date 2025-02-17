{ pkgs, inputs, ... }: {

  home.packages = with pkgs; [
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
    grimblast
    wl-clipboard
    swaylock-fancy
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    # plugins = [
    #   inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
    # ];
  };

  programs.swaylock = {
    enable = true;
  };
  
  services.dunst.enable = true;

  imports = [
    ./hyprconf
    ./rofi
    ./wlogout.nix
  ];
}
