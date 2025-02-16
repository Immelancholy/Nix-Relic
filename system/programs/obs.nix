{ pkgs, ... } : {
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = with pkgs; [
      obs-vkcapture
      obs-vaapi
      obs-nvfbc
    ];
  };
}
