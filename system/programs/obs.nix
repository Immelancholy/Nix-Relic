{ pkgs, ... } : {
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs; [
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-nvfbc
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };
}
