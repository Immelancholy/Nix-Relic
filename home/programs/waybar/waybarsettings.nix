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
        "custom/cava"
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
        "pulseaudio#mic"
        "network"
        "custom/r_end"
        "custom/l_end"
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
        separate-outputs = true;
        max-length = 50;
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
        icon-size = 16;
        spacing = 5;
      };
      "clock" = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      "cpu" = {
        interval = 10;
        format = "󰍛 {usage}%";
        format-alt = "{icon0}{icon1}{icon2}{icon3}";
        format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
      };

      "memory" = {
        states = {
          c = 90;
          h = 60;
          m = 30;
        };
        interval = 30;
        format = "󰾆 {used}GB";
        format-m = "󰾅 {used}GB";
        format-h = "󰓅 {used}GB";
        format-c = " {used}GB";
        format-alt = "󰾆 {percentage}%";
        max-length = 10;
        tooltip = true;
        tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
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
        format-wifi = "{essid} ({signalStrength}%)  ";
        format-ethernet = "{ipaddr}/{cidr} 󰈀 ";
        tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
        format-linked = "󰈀 {ifname} (No IP)";
        format-disconnected = "Disconnected 󰖪";
        format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
        interval = 2;
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
      "pulseaudio#mic" = {
        scroll-step = 1;
        format = "{format_source}";
        format-source = "󰍬";
        format-source-muted = "󰍭";
        on-click = "pavucontrol";
        tooltip-format = "{format_source} {source_desc} // {source_volume}%";
      };
      "custom/power" = {
        format = "⏻ ";
        tooltip = false;
        on-click = "wlogout";
      };
      #Custom padding mmodules
      "custom/l_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/r_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/sl_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/sr_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/rl_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/rr_end" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/padd" = {
        format = " ";
        interval = "once";
        tooltip = false;
      };
      "custom/cava" = {
        format = "{}";
        exec = "~/.local/share/bin/waycava.sh stdout --stb 3";
        on-click = "playerctl --player=mpd play-pause";
        on-scroll-down = "playerctl --player=mpd next";
        on-scroll-up = "playerctl --player=mpd previous";
        restart-interval = 1;
      };
    };
  };
}
