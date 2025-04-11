{
  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      # source = ["/etc/xdg/hypr/hyprland.conf"];
      "$scr" = "$XDG_BIN_HOME";
      "$term" = "uwsm app -- kitty";
      "$files" = "uwsm app -- nemo.desktop";
      "$filest" = "uwsm app -- yazi.desktop";
      "$mod" = "SUPER";
      "$mods" = "SUPERSHIFT";
      "$menu" = ''rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser power-menu -modi drun,run,filebrowser,power-menu:rofi-power-menu'';
      "$browser" = "uwsm app -- zen.desktop";
      "$edit" = "uwsm app -- nvim.desktop";
      "$player" = "mpd";
      "$playerctl" = "uwsm app -- playerctl --player=$player";
      "$discord" = "uwsm app -- vesktop.desktop";
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        key_press_enables_dpms = true;
        vfr = true;
      };
    };
  };
  imports = [
    ./binds.nix
    ./theme
    ./execs.nix
    ./windowrules.nix
  ];
}
