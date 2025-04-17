{
  imports = [
    ./nvidia.nix # For Nvidia Drivers
    ./amd.nix # For AMD Drivers
    ./secboot.nix
    ./locale.nix
    ./nvidia-prime.nix
    ./intel.nix
    ./steam.nix
    ./gamescopeSesh.nix
  ];
}
