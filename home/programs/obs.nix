{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {nixpkgs.config.cudaSupport = true;};
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      droidcam-obs
      obs-pipewire-audio-capture
    ];
  };
}
