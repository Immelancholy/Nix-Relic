{pkgs, ...}: {
  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd uwsm start default";
        user = "greeter";
      };
    };
  };
}
