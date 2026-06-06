{ self, ... }:
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
    self.inputs.solaar.nixosModules.default
  ];
}
