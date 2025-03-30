{
  pkgs,
  hyprMonitor,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "hyprland --config /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };
  environment.etc."greetd/hyprland.conf".text = ''
    monitor = ${hyprMonitor}
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_qtutils_check = true
    }
  '';
}
