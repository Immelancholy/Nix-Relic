# Nix-Relic Dotfiles
### Nixos Hyprland template (Also Basically what I use). 

## Colours generated automatically to match wallpaper by Stylix

![SS1](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/screenshots/SS1.png)

![SS2](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/screenshots/SS2.png)

![SS3](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/screenshots/SS3.png)

## Installation
> [!WARNING]
> Meant for a minimal install of nixos, ymmv
* Add this line to your configuration.nix in /etc/nixos/
```
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
  };
```
* Run: 
```
sudo nixos-rebuild switch
```
* install git temporarily with: 
```
nix-shell -p git
```
* run:
```
mkdir -p Nix-Relic (or anything rly this is just the name of the repo); cd Nix-Relic
```
* then:
```
nix flake init -t github:Immelancholy/Nix-Relic
```
* Enter configuration.nix and change to you liking:
```
{
  pkgs,
  nix-relic,
  ...
}: {
  nix-relic = {
    flakePath = "/path/to/flake/folder";
    cava = {
      framerate = 60;
      noiseReduction = 30;
    };
    framerates = {
      steamGamescopeSession = 60;
      neo = 60;
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
      compositor = "kwin";
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
```
* edit hyprland config to your liking.
* run this command in the same folder that flake.nix is located. (Where you've hopefully been this whole time lol)
```
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
* then:
```
git init && git add .
```
* Then run:
```
sudo nixos-rebuild boot --flake .#nix-relic
```
* reboot your pc.
## POST-INSTALL
* Remember to set default device to Desktop Output and Desktop Mic Out in pavucontrol (Not necessary but I would recommended)
* Set default device to Commes Output and Commes Mic In in discord lol (Again not necessary but splitting desktop and commes audio is useful)
* Then set up a qpwgraph patchbay (this launches on workspace 4 on boot) to pin the output and input virtual devices to your audio device.
* enable secureboot in configuration.nix (optional) (set it up using the guide [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md) first, you don't have to set up lanzaboote, just the stuff with key creating, signing and enrolling).
```
boot.secureBoot.enable = false; #secure boot (keep disabled and set up post-install)
```
* Set up your monitor (optional)
```
monitor = ", preferred, auto, 1";
```
* Set up easyeffects sink and source.
* You also need to make a patchbay in qpwgraph routing Desktop/Commes Output your audio sink and Desktop/Commes Mic In to the easyeffects source.
* Remember to run either
```
sudo nixos-rebuild switch --flake .
```
* in the dots folder
* Do this after making any changes in the dots folder.
```

relic-cli
* Recently I made a bash script called relic-cli, this should work as a all around tool for managing your install!
```
    usage: relic-cli [-t] [-r [host]] [option]

    options:
    -h, --help                               Show this help message and exit
    -u, --update                             Update the system
    -s, --switch [configuration]             Switch the configuration (e.g. . or .#config)
    -b, --boot   [configuration]             Switch the configuration on next boot (e.g. . or #config)
    -r, --remote [host]                      Perform switch or boot on remote host
    -t, --token                              Use gh token for updates
    -f['flakes'], --update-flake=['flakes']  Update all or selected flake inputs
```

# DISCLAIMER
* A lot of the waybar CSS, settings and the animations used in hyprland were copied over from the [HYDE Project](https://github.com/HyDE-Project/HyDE), although with some changes. These guys' hyprland template rocks and as I was using it before on arch I kinda just wanted my waybar to look like that. The cava module for waybar was also copied from this project.
* All images and videos used for this theme (I.E for fastfetch or wallpapers), belong to their own respective owners. I claim no ownership of them.
* The wallpapers I pulled from various wallpaper sites and even found the same ones on multiple different sites., so I'm not sure who their original owners are, however the images for fastfetch are all pulled from [@Alerria_V's](https://x.com/aleriia_v) twitter page. I will not redistribute their artwork in the actual repository and instead used pkgs.fetchurl to dowload them on rebuild. Please support them! They make great art and if I had money I would probably commission them. Alas, I am broke.

