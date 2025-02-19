{
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/mela/.steam/root/compatibilitytools.d";
    EDITOR = "/home/mela/.local/share/bin/kitty_nvim.sh";

    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead
    # (despite it being blacklisted)
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Hardware cursors are currently broken on wlroots
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
    AQ_TRACE = "1";
    AQ_DRM_DEVICES = "/dev/dri/card0";
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "20";
  };
}
