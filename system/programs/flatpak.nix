{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.obsproject.Studio"
      "org.freedesktop.Platform.VulkanLayer.OBSVkCapture"
    ];
  };
}
