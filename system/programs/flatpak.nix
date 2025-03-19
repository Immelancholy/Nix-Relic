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
      "com.obsproject.Studio.Plugin.DroidCam"
      "com.obsproject.Studio.Plugin.OBSVkCapture"
      "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/24.08"
      "com.obsproject.Studio.Plugin.GStreamerVaapi"
      "org.freedesktop.Platform.GStreamer.gstreamer-vaapi//22.08"
    ];
  };
}
