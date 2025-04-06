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
* To use please do as instructed in these comments in the flake.nix file
```
  outputs = {
    self,
    nixpkgs,
    stylix,
    catppuccin,
    home-manager,
    solaar,
    rust-overlay,
    nix-flatpak,
    lanzaboote,
    nur,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mela"; # Replace with your username
    git = "Immelancholy"; #Replace with your Git username
    email = "lenalowes0@gmail.com"; # Replace with your Git email
    scriptBin = "/home/${user}/.local/share/bin"; #path to scripts must point to a home folder dir i.e /home/${user}/path/to/scripts cos I used home.file to import them.
    hyprMonitor = ", preferred, auto, 1"; # monitor for hyprland to use, leave this default and then edit it in post install by using hyprctl monitors to find your monitor
    # hyprMonitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8"; #example and also my monitor lol
  in {
```
* Then go into the system folder and edit drivers.nix and set to your gpu.

```
{
  drivers = {
    amd.enable = false;
    nvidia.enable = true;
  };
}
```
* If you use nvidia make sure whether to select if you want to use the open source drivers in the nvidia.nix file:
```
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.

    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
```
* go into the system folder in this repo and delete hardware-configuration.nix, then run:
```
sudo nixos-generate-config --show-hardware-config > hardware-configuration.nix
```
* delete the contents of /etc/nixos and copy the contents of this repo there.
* then in the /etc/nixos folder run:
```
git init && git add .
```
* then still in the /etc/nixos folder run:
```
sudo nixos-rebuild boot --flake .
```
* reboot your pc.
## POST-INSTALL
* Remember to set default device to Desktop Output and Desktop Input in pavucontrol (Not necessary but I would recommended)
* Set default device to Commes Output and Commes Input in discord lol (Again not necessary but splitting desktop and commes audio is useful)
* Then set up a qpwgraph patchbay (this launches on workspace 4 on boot) to pin the output and input virtual devices to your audio device.
* enable secureboot (optional) (set it up using the guide [here](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md)).
* Set up your monitor (optional)
```

  } @ inputs: let
    system = "x86_64-linux";
    user = "mela"; # Replace with your username
    git = "Immelancholy"; #Replace with your Git username
    email = "lenalowes0@gmail.com"; # Replace with your Git email
    scriptBin = "/home/${user}/.local/share/bin"; #path to scripts must point to a home folder dir i.e /home/${user}/path/to/scripts cos I used home.file to import them.
    hyprMonitor = ", preferred, auto, 1"; # monitor for hyprland to use, leave this default and then edit it in post install by using hyprctl monitors to find your monitor
    # hyprMonitor = "HDMI-A-1, 1920x1080@144, 0x0, 1, bitdepth, 8"; #example and also my monitor lol
  in {
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


