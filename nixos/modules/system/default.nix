{
  imports = [
    ./nvidia.nix # For Nvidia Drivers
    ./amd.nix # For AMD Drivers
    ./secboot.nix
    ./locale.nix
  ];
}
