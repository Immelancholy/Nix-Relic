{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "systemd-restarts"
      "systemctl start --user qpwgraph"
      ''[workspace 1 silent; float; size 888 462; move 610 609] $term --class "cava" cava.sh''
      ''[workspace 1 silent; float; size 590 637; move 10 433] $term --class "btop" btop.sh''
      ''[workspace 1 silent; float; size 402 1030; move 1508 42] $term --class "neo" neo.sh''
      ''[workspace 1 silent; float; size 590 383; move 10 42] $term --class "fastfetch" kitty @ launch --type overlay --env class="fastfetch"''
      "[workspace 2 silent] $browser"
      "uwsm app -- $discord"
    ];
  };
}
