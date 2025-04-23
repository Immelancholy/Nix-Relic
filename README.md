# Nix-Relic Dotfiles
### Nixos Hyprland template (Also Basically what I use). 

https://github.com/user-attachments/assets/669d0a3e-0035-4646-9147-a5affd1d3237

![SS1](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/Screenshots/SS1.png)

![SS2](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/Screenshots/SS2.png)

![SS3](https://raw.githubusercontent.com/Immelancholy/Nix-Relic/refs/heads/main/Screenshots/SS3.png)

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
    services.mpd = {
      extraConfig = ''
        audio_output {
          type  "pipewire"
          name  "Pipewire Sound Server"
          target  "easyeffects_sink"
        }
      '';
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
```
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
* or just use the alias ```switch``` that I added that automatically adds and commits changes to the git repo and runs the above command.
* Do this after making any changes in the dots folder.
I also have aliases for switch on boot and updating with:
```
boot
```
and
```
update
```
### Image Sources
* [Backgound Fallen Angel](https://www.uhdpaper.com/2025/02/3565c-anime-girl-angel-devil-wings-4k.html?m=0)
* [Background Neon Beast Girl](https://mylivewallpapers.com/fantasy/neon-beast-girl-live-wallpaper/)
* [CatGirl.jpg](https://x.com/yoroikemomimi/status/1885903024549417009)
* [DemonGirl.jpg](https://x.com/yoroikemomimi/status/1883052457296830535)
* [DragonGirl.jpg](https://x.com/yoroikemomimi/status/1875533808394805415)
* [FallenAngel.jpg](https://x.com/yoroikemomimi/status/1881620165252788451)
* [GhostGirl.jpg](https://x.com/yoroikemomimi/status/1883359123867312141)
* [Morrigan.jpg](https://x.com/yoroikemomimi/status/1849691722772844834)
* [tomoe.png](https://www.pngwing.com/en/free-png-pjhwm/)


