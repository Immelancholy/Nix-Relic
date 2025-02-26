{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
    inputs.swww.packages.${pkgs.system}.swww
    libnotify
    hypridle
    hyprpicker
    xdg-desktop-portal-gtk
    grimblast
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    plugins = [
      # inputs.hyprtasking.packages.${pkgs.system}.hyprtasking
      inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
      inputs.hyprland-plugins.packages.${pkgs.system}.xtra-dispatchers
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
    ];
  };

  programs.swaylock = {
    enable = true;
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  services.udiskie = {
    enable = true;
    notify = true;
    tray = "always";
    automount = true;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        frame_color = "#cba6f7c0";
        separator_color = "frame";
        highlight = "#89b4fac0";
        frame_width = 2;
        corner_radius = 10;
        origin = "top-right";
        offset = "(54, 18)";
      };
      urgency_low = {
        background = "#1e1e2ec0";
        foreground = "#cdd6f4";
      };
      urgency_normal = {
        background = "#1e1e2ec0";
        foreground = "#cdd6f4";
      };
      urgency_critical = {
        background = "#1e1e2ec0";
        foreground = "#cdd6f4";
        frame_color = "#fab387c0";
      };
    };
  };

  imports = [
    ./hyprconf
    ./rofi
    ./wlogout.nix
  ];
}
