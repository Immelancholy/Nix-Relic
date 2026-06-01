{ inputs, ... }:
{
  imports = [
    ./boot
    ./drivers
    ./programs
    ./services
    ./locale.nix
    ./users.nix
    ./home-manager.nix
    ./wallpaper.nix
    ./system
    ./nix-relic.nix
    inputs.nix-relic.inputs.solaar.nixosModules.default
  ];
}
