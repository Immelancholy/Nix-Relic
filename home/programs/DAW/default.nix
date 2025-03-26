{pkgs, ...}: {
  home.packages = with pkgs; [
    reaper
    bespokesynth
    reaper-sws-extension
  ];
}
