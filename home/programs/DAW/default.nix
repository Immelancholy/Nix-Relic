{pkgs, ...}: {
  home.packages = with pkgs; [
    reaper
    bespokesynth
  ];
}
