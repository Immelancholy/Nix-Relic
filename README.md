# My NixOS Dots
### My NixOS Dotfiles, basically being updated near constantly as I change them.

https://github.com/user-attachments/assets/669d0a3e-0035-4646-9147-a5affd1d3237

![SS1](https://raw.githubusercontent.com/Immelancholy/Nix-Dotfiles/refs/heads/main/Screenshots/SS1.png)

![SS2](https://raw.githubusercontent.com/Immelancholy/Nix-Dotfiles/refs/heads/main/Screenshots/SS2.png)

![SS3](https://raw.githubusercontent.com/Immelancholy/Nix-Dotfiles/refs/heads/main/Screenshots/SS3.png)

## Installation
> [!WARNING]
> This config is what I use on my pc, it will have software you have no need for. I have tried my best to make it more accessible by setting up variables for user and git and having all home paths use either ```$HOME``` or ```/home/${user}/``` but I can't guarantee I fixed it all, if you notice something along those lines please make an issue and I'll try to fix it fast. These dotfiles also change constantly according to my needs so if you update with these you will lose or gain software that was/wasn't installed before.
> Basically YMMV.
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
* Clone this repo: 
```
git clone https://github.com/Immelancholy/Nix-Dotfiles.git
```
* enter the newly created Nix-Dotfiles folder
* Enter configuration.nix and change to you liking:
```
{
  userAccounts.users = [];
  userAccounts.sudoUsers = []; #Define users, sudoUsers can run sudo
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
```
* Enter home-configuration.nix and change to your liking setting git username and email and changing hyprland settings:
```
{
  programs.git = {
    enable = true;
    userName = "";
    userEmail = "";
  };
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
        kb_layout = "gb"; # Keyboard layout for hyprland
        follow_mouse = "1";

        sensitivity = "0";
        force_no_accel = "1";
        numlock_by_default = "true";
      };
    };
  };
}
```
* run this command in the same folder that flake.nix is located. (Where you've hopefully been this whole time lol)
```
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
* Then still in that folder run:
```
sudo nixos-rebuild boot --flake .
```
* reboot your pc.
## POST-INSTALL
* Remember to set default device to Desktop Output and Desktop Mic Out in pavucontrol (Not necessary but I would recommended)
* Set default device to Commes Output and Commes Mic In in discord lol (Again not necessary but splitting desktop and commes audio is useful)
* Then set up a qpwgraph patchbay (this launches on workspace 4 on boot) to pin the output and input virtual devices to your audio device.
* enable secureboot in system/boot.nix (optional) (set it up using the guide [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md)).
```
boot.secureBoot.enable = false; #secure boot (keep disabled and set up post-install)
```
* Set up your monitor (optional)
```
monitor = ", preferred, auto, 1";
```
* You'll want to configure mpd to use your actual audio device as the output in home/programs/mpd/default.nix (currently uses easyeffects sink so optional)
```
        audio_output {
          type  "pipewire"
          name  "Pipewire Sound Server"
          target  "easyeffects_sink"
        }
```
* Same with cava except you want to set it to the object.serial of virtual cable. Can be found with 
```
wpctl status
```
followed by 
```
wpctl inspect ID of Virtual Cable from wpctl status
```
In my case for example
```
wpctl inspect 43
```
Which give me an object.serial of 44, then I'd input that in home/programs/cava/default.nix
```
      };
      input = {
        method = "pipewire";
        source = "44";
        sample_rate = 48000;
        sample_bits = 32;
      };
```
* You also need to make a patchbay in qpwgraph routing Desktop Output/Input and Commes Output/Input to your audio sink and audio source.
* Remember to run either
```
sudo nixos-rebuild switch --flake .
```
* in the /etc/nixos folder
* or just use the alias ```switch``` that I added that automatically adds and commits changes to the git repo and runs the above command.
* Do this after making any changes in the /etc/nixos/ folder.
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


