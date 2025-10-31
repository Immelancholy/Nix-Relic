{inputs, ...}: {
  imports = [
    ./wayland
    ./programs
    ./home
    inputs.nixvim.homeModules.nixvim
    inputs.artis.homeManagerModules.default
  ];
}
