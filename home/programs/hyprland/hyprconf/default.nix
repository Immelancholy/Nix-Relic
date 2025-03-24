{
  wayland.windowManager.hyprland.settings = {
    "$scr" = "$HOME/.local/share/bin/";
    "$term" = "uwsm app -- kitty";
    "$files" = "$term uwsm app -- yazi";
    "$files2" = "uwsm app -- nemo";
    "$mod" = "SUPER";
    "$mods" = "SUPERSHIFT";
    "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'';
    "$browser" = "uwsm app -- zen";
    "$edit" = "$term $scr/nv.sh";
    "$player" = "mpd";
    "$playerctl" = "uwsm app -- playerctl --player=$player";
    # monitor = ", preferred, auto, 1";
    monitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8";
    input = {
      kb_layout = "gb";
      kb_options = "fkeys:basic_13-24";
      follow_mouse = "1";

      sensitivity = "0";
      force_no_accel = "1";
      numlock_by_default = "true";
    };
    dwindle = {
      pseudotile = true;
      preserve_split = true;
      # smart_split = true;
    };
  };

  imports = [
    ./binds.nix
    # ./env.nix
    ./theme.nix
    ./animations.nix
    ./execs.nix
    ./windowrules.nix
    ./plugins.nix
    ./hyprspace.nix
  ];
}
