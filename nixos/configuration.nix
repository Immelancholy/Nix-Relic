{
  pkgs,
  config,
  ...
}: {
  userAccounts.users = [
  ]; # user accounts here
  userAccounts.sudoUsers = [
    "your-user"
  ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )

  # duplicate this for each user
  home-manager.users.your-user = {
    programs.git = {
      enable = true;
      userName = ""; # username for git
      userEmail = ""; # email for git
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
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
        cursor = {
          no_hardware_cursors = false;
        };
        monitor = ", preferred, auto, 1";
        input = {
          kb_layout = "gb";
          follow_mouse = "1";

          sensitivity = "0";
          force_no_accel = "1";
          numlock_by_default = "true";
        };
        bind = [];
      };
    };
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      plugins = {
        obisdian = {
          enable = false; # switch this to true to enable obsidian.nvim
          settings = {
            ui.enable = false;
            workspaces = [
              {
                name = ""; # name of obsidian vault
                path = ""; # path to obsidian vault
              }
            ];
          };
        };
      };
    };
    home.sessionVariables = {
      NOTES_PATH = ""; # path to notes folder ( for neovim )
      PROJECTS_PATH = ""; # path to Projects folder ( for neovim )
    };
    # packages for user
    home.packages = with pkgs; [
      # reaper
      # bespokesynth
      # reaper-sws-extension
      # teams-for-linux
      # shotcut
      # krita
    ];
    services.flatpak = {
      packages = [
        "com.github.PintaProject.Pinta"
      ];
    };
  };

  # services.solaar.enable = true;
  # hardware.logitech.wireless.enable = true; # uncomment these if you have a logitech mouse

  environment.sessionVariables = {
    FLAKE_PATH = ""; #path to dots
  };

  drivers = {
    amd.enable = true;
    intel.enable = false;
    nvidia = {
      enable = false;
      open = true;
      powerManagement = true;
      finePowerManagement = false;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta; # example of custom package
      prime = {
        enable = false;
        # intelBusId = ""; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "";
      };
    };
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
