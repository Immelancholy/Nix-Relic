{
  userAccounts.users = [];
  userAccounts.sudoUsers = [];
  drivers = {
    amd.enable = true;
    nvidia.enable = false;
  };
  displayManager = {
    sddm.enable = true;
    tuiGreet.enable = false;
  };
  locale = "en_GB.UTF-8";

  services.xserver.xkb = {
    layout = "gb";
    model = "";
    variant = "";
    options = "";
  };
  console = {
    earlySetup = true;
    keyMap = "uk";
  };
  time.timeZone = "Europe/London";
  boot.secureBoot.enable = false;
}
