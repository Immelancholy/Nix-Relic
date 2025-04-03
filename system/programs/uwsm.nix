{pkgs, ...}: let
  config = pkgs.writeTextDir "/etc/hyprgame/hyprgame.conf" ''
    $term = uwsm app -- kitty
    $menu = rofi -show drun -run-command "uwsm-app -- {cmd}" run filebrowser -modi drun,run,filebrowser
    $mod = SUPER
    $mods = SUPERSHIFT

    env = XDG_CURRENT_DESKTOP,Hyprland

    general {
      gaps_in = 3
      gaps_out = 8
      border_size = 2

      layout = dwindle
      resize_on_border = true
    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }
    animations {
      enabled = 0
    }
    input {
      kb_layout = gb

      follow_mouse = 1

      sensitivity = 0
      force_no_accel = 1
      numlock_by_default = true
    }
    bind = $mod, mouse_up, workspace, r+1
    bind = $mod, mouse_down, workspace, r-1
    bind = $mods, q, killactive
    bind = $mod, t, exec, $term
    bind = $mod, grave, exec, $menu
    bind = $mod, Delete, exec, uwsm stop
    bind = Alt, Return, fullscreen
    bind = $mod+Ctrl+Alt, Right, movetoworkspace, r+1
    bind = $mod+Ctrl+Alt, Left, movetoworkspace, r-1

    exec-once = $term
    exec-once = [workspace 2] uwsm app -- DiscordCanary
    exec-once = [workspace 3 silent] uwsm app -- zen
    exec-once = [workspace 4 silent] uwsm app -- qpwgraph
    exec-once = [workspace 4 silent] uwsm app -- qpwgraph
    exec-once = sleep 12; systemctl restart --user cliphist cliphist-images nm-applet remmina
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
  '';
  hg = pkgs.writeShellScriptBin "hg" ''
    exec Hyprland --config ${config}/etc/hyprgame/hyprgame.conf
  '';
in {
  environment.systemPackages = [
    hg
    config
  ];
  programs = {
    uwsm = {
      enable = true;
      waylandCompositors = {
        hyprgame = {
          prettyName = "Hyprland (GameMode)";
          comment = "Barebones config to go with steamdeck mode";
          binPath = "/run/current-system/sw/bin/hg";
        };
      };
    };
  };
}
