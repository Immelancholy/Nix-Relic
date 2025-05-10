{
  pkgs,
  # inputs,
  # config,
  ...
}: {
  networking.hostName = "nix-relic";
  userAccounts.users = [
  ]; # user accounts here
  userAccounts.sudoUsers = [
    "your-user"
  ]; # sudo enabled accounts here (You'll want to go here if you're installing these. )

  programs.weylus.users = [
    "users you want to have access to weylus"
  ];

  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"; # Stylix theme, comment this to generate theme based on wallpaper
    polarity = "dark";

    image = ./nixos/home/backgrounds/Evil_Miku.png;
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.allowed-rates" = [44100 48000 88200 96000];
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 512;
      "default.clock.quantum-limit" = 4096;
      "default.clock.quantum-floor" = 32;
    };
  };

  environment.systemPackages = with pkgs; [
    # global packages here
  ];

  # duplicate this for each user
  home-manager.users.your-user = {
    imports = [
      ./nixos/home/fetch_images.nix
    ];

    catppuccin = {
      flavor = "mocha";
      accent = "mauve";
    };

    # stylix.targets = {
    #   # comment this if you don't want catppuccin theme, I made a module to autodisable their respective catppuccin themes.
    #   tmux.enable = false;
    #   yazi.enable = false;
    #   btop.enable = false;
    #   spicetify.enable = false;
    #   kitty.enable = false;
    #   nixvim.enable = false;
    #   zen.enable = false;
    #   vesktop.enable = false;
    # };

    programs.vesktop = {
      enable = true;
    };

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

    services.mpd = {
      extraConfig = ''
        audio_output {
          type  "pipewire"
          name  "Pipewire Sound Server"
          target  "easyeffects_sink"
        }
      '';
    };

    player = {
      enable = true;
      # name = ""; #MPRIS name of the player (defaults to mpd)
      # cmd = ""; # command to launch music player (defaults to mpd)
      # class = ""; # wmclass of music player (defaults to mpd)
      # scriptUseDefaultSink = true; #Use default sink for vol control script (defaults to false)
    };

    # Important hyprland user configs
    wayland.windowManager.hyprland = {
      # ONLY ENABLE 1 LAYOUT!!
      layout = {
        master.enable = false;
        dwindle.enable = false;
        hy3.enable = true;
      };
      useHyprspace = false;
      liveWallpaper = {
        enable = true;
        path = ./nixos/home/backgrounds/Evil_Miku.mp4;
      };
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
        bind = [
          # "$mod, F9, pass, class:^(com.obsproject.Studio)$"
          # "$mod, F10, pass, class:^(com.obsproject.Studio)$"
          # "$mod, F12, pass, class:^(com.obsproject.Studio)$"
        ];
      };
    };

    home.sessionVariables = {
      NOTES_PATH = ""; # path to notes folder ( for neovim )
      PROJECTS_PATH = ""; # path to Projects folder ( for neovim )
    };

    home.packages = with pkgs; [
      # Packages for this user only here
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      plugins = {
        obsidian = {
          enable = false;
          settings = {
            ui.enable = false;
            workspaces = [
              {
                name = "";
                path = "";
              }
            ];
          };
        };
      };
    };
  };

  services.qpwgraph.enable = true;

  # services.solaar.enable = true; # logitech mouse stuff
  # hardware.logitech.wireless.enable = true; # logitech mouse stuff

  environment.sessionVariables = {
    FLAKE_PATH = "/home/user/Nix-Relic"; # path to dots folder, do like this example
    FRAMERATE = 60; # monitor refresh rate
  };

  programs.steam = {
    enable = false;
    gamescopeSession.enable = true;
  };

  services.mpdchck = {
    enable = false;
  };

  drivers = {
    amd.enable = true;
    intel.enable = false;
    nvidia = {
      enable = false;
      open = true;
      powerManagement = true;
      finePowerManagement = false;
      # package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;
      prime = {
        enable = false;
        # intelBusId = ""; # For Intel
        # amdgpuBusId = ""; # For AMD
        nvidiaBusId = "";
      };
    };
  };

  displayManager = {
    # Display Manager to user, only enable 1
    sddm = {
      enable = false; #logout doesn't work right forcing you to do systemctl restart display-manager to get sddm to pop up again after logging out
      screenWidth = "1920";
      screenHeight = "1080";
      animatedBackground = {
        enable = true;
        path = ./nixos/home/backgrounds/Evil_Miku.mp4;
      };
    };
    tuiGreet.enable = true;
  };

  locale = "en_GB.UTF-8"; # change to your locale

  services.xserver.xkb = {
    layout = "gb"; # change to your keyboard layout
    model = "";
    variant = "";
    options = "";
  };

  console = {
    earlySetup = true;
    keyMap = "uk"; # change to your keyboard layout
  };

  time.timeZone = "Europe/London"; # set to your timezone

  boot.secureBoot.enable = false; # set up secure boot post-install before enabling this
}
