{
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${config.programs.regreet.package}/bin/regreet";
        user = "greeter";
      };
    };
  };
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-m"
      "last"
    ];
  };
}
