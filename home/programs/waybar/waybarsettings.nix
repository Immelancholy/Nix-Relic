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

      "hyrpland/window" = {
        format = " 󱄅 {app_id}";
        spacing = 0;
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
      "network" = {
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} 󰊗";
        tooltip-format = "{ifname} via {gwaddr} 󰈁";
        format-linked = "{ifname} (No IP) 󰈂";
        format-disconnected = "Disconnected 󰖪";
        format-alt = "{ifname}: {ipaddr}/{cidr}";
      };
      "pulseaudio" = {
        scroll-step = 1;
        format = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "󰂑";
          headset = "󰂑";
          phone = "";
          portable = "";
          car = "";
          default = [
            ""
            ""
            ""
          ];
        };
        on-click = "pavucontrol";
      };
      "custom/power" = {
        format = "⏻ ";
        tooltip = false;
        on-click = "wlogout";
      };
    };
  };
}
