{
  wayland.windowManager.hyprland.extraConfig = ''
    plugin {
      hyprtrails {
        color = rgba(cba6f7ff)
      }
    }
    plugin {
        hyprwinwrap {
            # class is an EXACT match and NOT a regex!
            class = kitty-bg
        }
    }
  '';
}
