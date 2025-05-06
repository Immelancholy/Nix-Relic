let
  associations = {
    "inode/directory" = ["nemo.desktop"];
    "video/mp4" = ["mpv.desktop"];
    "video/quicktime" = ["mpv.desktop"];
    "image/png" = ["org.gnome.Loupe.desktop"];
    "image/jpeg" = ["org.gnome.Loupe.desktop"];
    "application/x-gnome-saved-search" = ["nemo.desktop"];
    "application/zip" = ["org.kde.ark.desktop"];
  };
in {
  xdg = {
    mime.enable = true;
    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };
}
