# My NixOS Dots
* My NixOS Dotfiles, basically being updated near constantly as I change them.

## Installation
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
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "mela"; # Replace with your username
    git = "Immelancholy"; #Replace with your GitHub username
    email = "lenalowes0@gmail.com"; # Replace with your GitHub email
  in {
```

* Then go into the modules folder and edit default.nix and comment/uncomment these modules to switch the GPU drivers for your pc.

```{
  imports = [
    ./nvidia.nix # For Nvidia Drivers
    #./amd.nix # For AMD Drivers
  ];
}
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
sudo nixos-rebuild switch --flake .
```
### Image Sources
* [Backgound](https://www.uhdpaper.com/2025/02/3565c-anime-girl-angel-devil-wings-4k.html?m=0)
* [CatGirl.jpg](https://x.com/yoroikemomimi/status/1885903024549417009)
* [DemonGirl.jpg](https://x.com/yoroikemomimi/status/1883052457296830535)
* [DragonGirl.jpg](https://x.com/yoroikemomimi/status/1875533808394805415)
* [FallenAngel.jpg](https://x.com/yoroikemomimi/status/1881620165252788451)
* [GhostGirl.jpg](https://x.com/yoroikemomimi/status/1883359123867312141)
* [Morrigan.jpg](https://x.com/yoroikemomimi/status/1849691722772844834)
* [tomoe.png](https://www.pngwing.com/en/free-png-pjhwm/)


