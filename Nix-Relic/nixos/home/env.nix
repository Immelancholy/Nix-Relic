{
  pkgs,
  lib,
  config,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    BROWSER = "zen";
    TERMINAL = "${lib.getExe pkgs.ghostty}";
    XCURSOR_THEME = config.stylix.cursor.name;
    XCURSOR_SIZE = config.stylix.cursor.size;
    GRIMBLAST_EDITOR = "swappy";
    MPD_HOST = "${config.services.mpd.network.listenAddress}";
    MPD_PORT = "${builtins.toString config.services.mpd.network.port}";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    GDK_SCALE = 1;
  };

  xdg.configFile =
    /*
    bash
    */
    {
      "uwsm/env".text = ''
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export QT_AUTO_SCREEN_SCALE_FACTOR=1
        export GDK_SCALE=1
        export XCURSOR_THEME="${config.stylix.cursor.name}"
        export XCURSOR_SIZE=${builtins.toString config.stylix.cursor.size}
        export NIXOS_OZONE_WL=1
        export QT_QPA_PLATFORM="wayland;xcb"
        export MOZ_ENABLE_WAYLAND=1
        export GDK_BACKEND="wayland,x11"
        export UWSM_ENABLED=1
        eval $(gnome-keyring-daemon -s)
        export SSH_AUTH_SOCK;
      '';
      "uwsm/env-hyprland".text = ''
        export HYPRCURSOR_THEME="${config.stylix.cursor.name}"
        export HYPRCURSOR_SIZE=${builtins.toString config.stylix.cursor.size}
      '';
    };
}
