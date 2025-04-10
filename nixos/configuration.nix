{pkgs, ...}: {
  userAccounts.users = [
  ]; # user accounts here
  userAccounts.sudoUsers = [
    "your-user"
  ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )

  # duplicate this for each user
  home-manager.users.your-user = {
    # packages for user
    home.packages = with pkgs; [
      # reaper
      # bespokesynth
      # reaper-sws-extension
      # teams-for-linux
      # shotcut
      # krita
    ];
    programs.git = {
      enable = true;
      userName = ""; # username for git
      userEmail = ""; # email for git
    };
    programs.cava = {
      settings = {
        input = {
          method = "pipewire";
          source = "58"; # Cava object.serial for virtual_cable_in
        };
      };
    };
    # Important hyprland user configs
    wayland.windowManager.hyprland = {
      # ONLY ENABLE 1 LAYOUT!!
      layout = {
        master.enable = false;
        dwindle.enable = false;
        hy3.enable = true;
      };
      useHyprspace = true;
      settings = {
        monitor = ", preferred, auto, 1";
        input = {
          kb_layout = "gb";
          follow_mouse = "1";

          sensitivity = "0";
          force_no_accel = "1";
          numlock_by_default = "true";
        };
      };
    };
  };

  # services.solaar.enable = true; #logitech mouse drivers

  environment.sessionVariables = {
    FLAKE_PATH = ""; #path to dots
  };

  drivers = {
    amd.enable = false;
    nvidia.enable = true;
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
  boot.secureBoot.enable = false; # Secure boot enable/disable
}
