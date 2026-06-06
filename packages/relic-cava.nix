{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "relic-cava";

  runtimeInputs = with pkgs; [
    kitty
    cava
  ];

  text = ''
    kitty @ set-spacing padding=0
    kitty @ set-font-size 3
    cava "$@"
    kitty @ set-spacing padding=default
    kitty @ set-font-size 10
  '';
}
