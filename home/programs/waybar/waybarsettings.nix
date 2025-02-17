{
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      
      modules-left = [
        "hyprland/workspaces"
        "cpu"
        "memory"
      ];
      modules-center = [
        "hyprland/window"
        "clock"
      ];
      modules-right = [
        "mpd"
        "idle_inhibitor"
        "network"
        "tray"
      ];
    };
  };
}
