{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
      obs-pipewire-audio-capture
      obs-composite-blur
    ];
  };
}
