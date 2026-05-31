{
  writeShellApplication,
  pkgs,
  ...
}:
writeShellApplication {
  name = "btop.sh";

  runtimeInputs = with pkgs; [
    kitty
    btop
  ];

  text = ''
    kitty @ set-font-size 9.5
    btop "$@"
    kitty @ set-font-size 10
  '';
}
