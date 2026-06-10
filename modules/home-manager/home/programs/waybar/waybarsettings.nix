{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) player;
  toggle-player = pkgs.toggle-player.override {
    playerTitle = player.title;
    playerCmd = player.cmd;
    playerClass = player.class;
    playerPkg = pkgs.zarumet;
  };
in
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
        "keyboard-state"
        "hyprland/submap"
        "custom/r_end"
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
        "battery"
        "custom/r_end"
        "custom/l_end"
        "pulseaudio"
        "pulseaudio#mic"
        "network"
        "bluetooth"
        "custom/r_end"
        "custom/l_end"
        "tray"
        "custom/update"
        "custom/r_end"
        "custom/l_end"
        "custom/power"
        "custom/r_end"
        "custom/padd"
      ];

      "hyprland/submap" = {
        format = "󰘳 {}";
        max-length = 30;
        tooltip = false;
        default-submap = "default";
        always-on = true;
        on-scroll-up = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"r-1\" })'";
        on-scroll-down = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"r+1\" })'";
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        active-only = false;
        on-click = "activate";
        disable-scroll = false;
        enable-bar-scroll = true;
        on-scroll-up = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"r-1\" })'";
        on-scroll-down = "hyprctl dispatch 'hl.dsp.focus({ workspace = \"r+1\" })'";
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
        format-icons = [
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        on-click-right = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe pkgs.toggle-btop}")'
        '';
      };
      "memory" = {
        states = {
          c = 90;
          h = 60;
          m = 30;
        };
        interval = 30;
        format = "󰾆 {used:0.1f}GB";
        format-m = "󰾅 {used:0.1f}GB";
        format-h = "󰓅 {used:0.1f}GB";
        format-c = " {used:0.1f}GB";
        format-alt = "󰾆 {percentage}%";
        max-length = 10;
        tooltip = true;
        tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
        on-click-right = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe pkgs.toggle-btop}")'
        '';
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
        on-click-right = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe pkgs.toggle-linktui} --tab=wifi")'
        '';
      };
      "bluetooth" = {
        format-on = " 󰂯";
        format-off = " 󰂲";
        format-connected = " 󰂯 {device_alias}";
        format-connected-battery = " 󰂯 {device_alias} {icon} {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        on-click = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe pkgs.toggle-linktui} --tab=bluetooth")'
        '';
        on-click-right = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe pkgs.toggle-linktui} --tab=bluetooth")'
        '';
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
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
        tooltip-format = "{icon} {desc} // {volume}%";
        on-click = "pwvucontrol -t 4";
      };
      "battery" = {
        interval = 5;
        states = {
          warning = 25;
          critical = 10;
        };
        format = "{icon} {capacity}%";
        format-charging = "{icon} {capacity}%";
        format-critical = "{icon} {capacity}%";
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      "pulseaudio#mic" = {
        scroll-step = 1;
        format = "{source_volume}% {format_source}";
        format-source = "󰍬";
        format-source-muted = "󰍭";
        on-click = "pwvucontrol -t 3";

        tooltip-format = "{format_source} {source_desc} // {source_volume}%";
      };
      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu ";
        on-click-right = "rofi -show power-menu -modi power-menu:rofi-power-menu ";
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
      "custom/cava" = {
        format = "{}";
        exec = "waycava.sh stdout --stb 3";
        on-click = "playerctl --player=${player.class} play-pause";
        on-click-right = ''
          hyprctl dispatch 'hl.exec_cmd("${lib.getExe toggle-player}")'
        '';
        on-scroll-down = "playerctl --player=${player.class} next";
        on-scroll-up = "playerctl --player=${player.class} previous";
        restart-interval = 1;
      };
      "custom/update" = {
        format = "󰚰";
        on-click = "uwsm app -- kitty --class update-system relic-cli -u";
        tooltip = true;
        tooltip-format = "Update System";
      };
    };
  };
}
