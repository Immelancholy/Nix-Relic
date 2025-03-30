{
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enabe = true;
    vt = 1;
    settings = {
      default_session = {
        command = "${config.programs.regreet.package}";
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
