{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # "hyprctl setcursor ${config.stylix.cursor.name} ${builtins.toString config.stylix.cursor.size}"
      "systemctl restart --user nm-applet"
      "sleep 10; systemctl restart --user remmina"
      ''[workspace 1 silent; float; size 858 462; move 640 609] $term --window-padding-x=0 --window-padding-y=0 --font-size=4 --class=cava.ghostty.screen1 -e cava -p "$XDG_CONFIG_HOME"/cava/vcConfig''
      ''[workspace 1 silent; float; size 620 637; move 10 433] $term --font-size=9 --class=btop.ghostty.screen1 -e btop''
      ''[workspace 1 silent; float; size 402 1030; move 1508 42]  $term --window-padding-x=0 --window-padding-y=0 --class=neo.ghostty.screen1 -e neo -a -S 20 -d 1 -f 144 -C "$XDG_CONFIG_HOME"/neo/colors -b 1 -m "Welcome, ''${USER^}." --lingerms=1,1 --rippct=0''
      ''[workspace 1 silent; float; size 620 383; move 10 42] env class="fastfetch" $term --class=fastfetch.ghostty.screen1''
      "[workspace 2 silent] $browser"
      "[workspace 2 silent] uwsm app -- teams-for-linux --minimized"
      "uwsm app -- $discord"
    ];
  };
}
