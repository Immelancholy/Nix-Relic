{
  pkgs,
  lib,
  ...
}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    EDITOR = "kitty $HOME/.local/share/bin/kitty_nvim.sh";
    BROWSER = "zen";
    TERMINAL = "${lib.getExe pkgs.kitty}";
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead
    # (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Hardware cursors are currently broken on wlroots
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
    AQ_TRACE = "1";
    AQ_DRM_DEVICES = "/dev/dri/card0";
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
    ENABLE_VKBASALT = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GDK_SCALE = "1";
    GRIMBLAST_EDITOR = "swappy";
  };
}
