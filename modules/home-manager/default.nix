self: {
  imports = [
    ./wayland
    ./programs
    ./home
    self.inputs.nixvim.homeModules.nixvim
    self.inputs.artis.homeManagerModules.default
  ];
}
