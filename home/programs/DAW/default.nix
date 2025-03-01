{pkgs, ...}: {
  home.packages = with pkgs; [
    reaper
    bespokesynth-with-vst2
  ];
}
