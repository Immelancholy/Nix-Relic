{pkgs, ...}: {
  programs.obs-studio = {
    package = pkgs.obs-studio.override {config.cudaSupport = true;};
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      droidcam-obs
      obs-pipewire-audio-capture
    ];
  };
}
