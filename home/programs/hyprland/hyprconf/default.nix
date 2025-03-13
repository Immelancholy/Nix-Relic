{
  wayland.windowManager.hyprland.settings = {
    "$scr" = "$HOME/.local/share/bin/";
    "$term" = "kitty";
    "$files" = "$term yazi";
    "$files2" = "nemo";
    "$mod" = "SUPER";
    "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}"'';
    "$browser" = "zen";
    "$edit" = "$term $scr/nv.sh";
    "$player" = "uwsm-app -- mpd";
    "$playerctl" = "uwsm-app -- playerctl --player=$player";
    monitor = ", 1920x1080@144, auto, 1";
    input = {
      kb_layout = "gb";
      kb_options = "fkeys:basic_13-24";
      follow_mouse = "1";

      sensitivity = "0";
      force_no_accel = "1";
      numlock_by_default = "true";
    };
    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
    };
  };

  imports = [
    ./binds.nix
    ./env.nix
    ./theme.nix
    ./animations.nix
    ./execs.nix
    ./windowrules.nix
    ./plugins.nix
    ./hyprspace.nix
  ];
}
