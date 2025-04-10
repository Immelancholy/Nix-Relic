{
  userAccounts.users = [];
  userAccounts.sudoUsers = []; #Define users, sudoUsers can run sudo

  environment.sessionVariables = {
    FLAKE_PATH = "/etc/nixos"; #path to flake.nix
  };

  drivers = {
    amd.enable = true;
    nvidia.enable = false; #drivers
  };

  displayManager = {
    #ONLY 1
    sddm.enable = true;
    tuiGreet.enable = false;
  };

  locale = "en_GB.UTF-8"; #locale

  services.xserver.xkb = {
    #keyboard for x
    layout = "gb";
    model = "";
    variant = "";
    options = "";
  };
  console = {
    #keymap for console
    earlySetup = true;
    keyMap = "uk";
  };
  time.timeZone = "Europe/London";
  boot.secureBoot.enable = false; #secure boot (keep disabled and set up post-install)
}
