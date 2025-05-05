{
  pkgs,
  lib,
  config,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    BROWSER = "zen";
    TERMINAL = "${lib.getExe pkgs.kitty}";
    XCURSOR_THEME = config.stylix.cursor.name;
    XCURSOR_SIZE = config.stylix.cursor.size;
    GRIMBLAST_EDITOR = "swappy";
    MPD_HOST = "${config.services.mpd.network.listenAddress}";
    MPD_PORT = "${builtins.toString config.services.mpd.network.port}";
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    GDK_SCALE = 1;
  };

  systemd.user.sessionVariables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/keyring/ssh";
    GNOME_KEYRING_CONTROL = "$XDG_RUNTIME_DIR/keyring";
  };
}
