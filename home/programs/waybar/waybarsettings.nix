{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      
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
        "custom/power"
      ];
    };
  };
}
