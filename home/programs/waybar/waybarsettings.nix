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
        "mpd"
        "cpu"
        "temperature"
        "memory"
        "pulseaudio"
        "network"
        "tray"
        "keyboard-state"
        "custom/power"
      ];

      "hyprland/workspaces" = {
        all-outputs = true;
        active-only = false;
        on-click = "activate";
        disable-scroll = false;
        on-scroll-up = "hyprctl dispatch workspace -1";
        on-scroll-down = "hyprctl dispatch workspace +1";
        persistent-workspaces = {
        };
      };

      "keyboard-state" = {
        numlock = true;
        capslock = true;
        format = "{name} {icon}";
        format-icons = {
          locked = "";
          unlocked = "";
        };
      };

      "mpd" = {
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
        format-disconnected = "Disconnected ";
        format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
        unknown-tag = "N/A";
        interval = 5;
        consume-icons = {
          on = " ";
        };
        "random-icons" = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = " "; 
        };
        "repeat-icons" = {
          on = " ";
        };
        "single-icons" = {
          on = "1 ";
        };
        "state-icons" = {
          paused = "";
          playing = "";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      "tray" = {
        spacing = 10;
      };
      "clock" = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      "cpu" = {
        format = "{usage}%";
        tooltip = false;
      };
      "temperature" = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [
          "" 
          "" 
          ""
        ];
      };
    };
  };
}
