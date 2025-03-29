{
  pkgs,
  user,
  ...
}: {
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd ${pkgs.uwsm}/bin/uwsm start hyprland-uwsm.desktop";
        user = "greeter";
      };
    };
  };
  services.seatd = {
    enable = true;
    user = "${user}";
  };
}
