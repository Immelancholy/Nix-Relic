{
  security.pam.services.greetd.enableGnomeKeyring = true;
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${pkgs.cage}/bin/cage -s -mlast ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };
  # programs.regreet = {
  #   enable = true;
  #   cageArgs = [
  #     "-s"
  #     "-m"
  #     "last"
  #   ];
  # };
}
