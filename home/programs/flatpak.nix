{
  services.flatpak = {
    overrides = {
      global = {
        Context.sockets = ["wayland" "!x11" "!fallback-x11"];

        Environment = {
          XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
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
