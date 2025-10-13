{inputs, ...}: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    configs = {
      hyprquickshot = "${inputs.hyprquickshot}";
    };
  };
}
