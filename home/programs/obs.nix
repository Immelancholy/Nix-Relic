{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-vaapi
      obs-gstreamer
      droidcam-obs
      obs-pipewire-audio-capture
      obs-backgroundremoval
    ];
  };
}
