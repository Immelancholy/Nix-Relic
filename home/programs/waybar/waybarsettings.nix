{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      mode = "dock";
      passthrough = true;
      exclusive = true;
      gtk-layer-shell = true;
      height = 28;
      spacing = 4;
      
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [
        "idle_inhibitor"
        "clock"
      ];
      modules-right = [
        "cpu"
        "memory"
        "pulseaudio"
        "network"
        "tray"
        "keyboard-state"
        "custom/power"
      ];
      "hyprland/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
        format = "{name}: {icon}";
        format-icons = {
          "1": "";
          "2": "";
          "3": "";
          "4": "";
          "5": "";
          "urgent": "";
          "focused": "";
          "default": "";
        };
      };
    };
  };
}
