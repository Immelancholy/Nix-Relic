{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = let
    fakeGnomeTerminal = pkgs.runCommand "fake-gnome-terminal" {} ''
      mkdir -p "$out/bin"
      ln -s "${pkgs.kitty}/bin/kitty" "$out/bin/gnome-terminal"
    '';
  in [
    (lib.hiPrio fakeGnomeTerminal)
  ];
}
