{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      droidcam-obs
      obs-pipewire-audio-capture
    ];
  };
}
