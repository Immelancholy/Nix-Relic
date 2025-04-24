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
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    ENABLE_VKBASALT = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1";
    GRIMBLAST_EDITOR = "swappy";
    MPD_HOST = "${config.services.mpd.network.listenAddress}";
    MPD_PORT = "${builtins.toString config.services.mpd.network.port}";
    NOTES_PATH = "$HOME/Documents/Obsidian-Vault"; # path to notes folder ( for neovim )
    PROJECTS_PATH = "$HOME/Documents/Projects"; # path to Projects folder ( for neovim )
  };

  systemd.user.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    GNOME_KEYRING_CONTROL = "/run/user/1000/keyring";
  };
}
