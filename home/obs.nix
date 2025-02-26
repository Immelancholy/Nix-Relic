{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      enableVirtualCamera = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      obs-vaapi
      obs-pipewire-audio-capture
      obs-composite-blur
    ];
  };
}
