{
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enabe = true;
    vt = 1;
    default_session = {
      command = "${config.programs.regreet.package}";
      user = "greeter";
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
