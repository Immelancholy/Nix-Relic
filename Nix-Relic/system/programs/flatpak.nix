{
  services.flatpak = {
    overrides = {
      global = {
        Environment = {
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";

          GTK_THEME = "Adwaita:dark";
        };
      };
    };
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "org.gimp.GIMP"
    ];
  };
}
