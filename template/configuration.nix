{
  pkgs,
  inputs,
  config,
  nix-relic,
  ...
}: {
  nix-relic = {
    hostHomeFolderStructure = false;
    flakePath = "/home/mela/NixDots";
    framerates = {
      cava = 144;
      steamGamescopeSession = 280;
    };
    wallpaper = {
      path = "${nix-relic}/backgrounds/Evil_Miku.png";
      animatedWallpaper = {
        enable = true;
        path = "${nix-relic}/backgrounds/Evil_Miku.mp4";
      };
    };
    users.users = {
      your-user = {
        isNormalUser = true;
        isAdmin = true; #enable or disable this to give or take sudo access.
        home-config = {
          stylix.iconTheme = {
            enable = true;
            package = pkgs.tela-circle-icon-theme.override {
              colorVariants = [
                "dracula"
              ];
            };
            dark = "Tela-circle-dracula";
            light = "Tela-circle-dracula";
          };

          programs.vesktop = {
            enable = true;
          };

          programs.git = {
            enable = true;
            settings = {
              user = {
                name = "";
                email = "";
              };
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
            useHyprspace = false; # Broken atm
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
      };
    };
  };

  networking.hostName = "nix-relic";
  programs.weylus.users = [
    "users you want to have access to weylus"
  ];

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

  services.qpwgraph.enable = true;

  # services.solaar.enable = true; # logitech mouse stuff

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
