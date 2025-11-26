{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "systemctl start --user qpwgraph"
      "[workspace 2 silent] $browser"
      "uwsm app -- $discord"
    ];
  };
}
