{pkgs, ...}: {
  home.packages = with pkgs; [
    nr.easyeffects
  ];
}
