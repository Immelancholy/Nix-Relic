self: {
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
    self.inputs.stylix.nixosModules.stylix
  ];
}
