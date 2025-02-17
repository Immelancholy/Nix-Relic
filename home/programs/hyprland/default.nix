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
  
  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#89b4fa";
        separator_color = "frame";
        highlight = "#89b4fa";
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#fab387";
      };
    };
  };

  imports = [
    ./hyprconf
    ./rofi
    ./wlogout.nix
  ];
}
