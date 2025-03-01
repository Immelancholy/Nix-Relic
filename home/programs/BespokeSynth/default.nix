{pkgs, ...}: {
  home.packages = with pkgs; [
    bespokesynth-with-vst2
  ];
}
