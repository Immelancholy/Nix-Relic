{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 30;
      spacing = 4;
      
      modules-left = [
        "hyprland/submap"
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
      ];
    };
  };
}
