{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "systemd-restarts"
      "systemctl start --user qpwgraph"
      "[workspace 2 silent] $browser"
      "uwsm app -- $discord"
    ];
  };
}
