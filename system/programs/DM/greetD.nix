{pkgs, ...}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s ${pkgs.greetd.gtkgreet}/bin/gtkgreet";
        user = "greeter";
      };
    };
  };
}
