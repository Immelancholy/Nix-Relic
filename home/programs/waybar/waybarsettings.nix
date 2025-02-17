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
      
      modules-left = [
        "custom/padd"
        "custom/l_end"
        "hyprland/workspaces"
        "hyprland/window"
        "custom/r_end"
        "custom/padd"
      ];
      modules-center = [
        "custom/padd"
        "custom/l_end"
        "idle_inhibitor"
        "clock"
        "custom/r_end"
        "custom/padd"
      ];
      modules-right = [
        "custom/padd"
        "custom/l_end"
        "cpu"
        "temperature"
        "memory"
        "pulseaudio"
        "custom/r_end"
        "custom/l_end"
        "network"
        "tray"
        "keyboard-state"
        "custom/power"
        "custom/r_end"
        "custom/padd"
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
      
      "hyprland/window" = {
        format = " 󱄅 {}";
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
          activated = "󰅶 ";
          deactivated = "󰛊 ";
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
        format-muted = "婢";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [
            " "
            " "
            " "
          ];
        };
        on-click = "pavucontrol";
      };
      "custom/power" = {
        format = "⏻ ";
        tooltip = false;
        on-click = "wlogout";
      };
      #Custom padding mmodules
      "custom/l_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/r_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/sl_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/sr_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/rl_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/rr_end" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
      "custom/padd" = {
        format = " ";
        intervel = "once";
        tooltip = false;
      };
    };
  };
}
