{inputs, ...}: {
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
    inputs.nix-relic.inputs.solaar.nixosModules.default
  ];
}
