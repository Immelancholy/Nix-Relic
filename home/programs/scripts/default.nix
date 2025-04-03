{
  scriptBin,
  user,
  lib,
  ...
}: let
  scriptBinHome = lib.strings.removePrefix "/home/${user}/" "${scriptBin}";
in {
  home.file = {
    "${scriptBinHome}" = {
      source = ./Bash;
      recursive = true;
      executable = true;
    };
  };
  imports = [
    ./hyprgame.nix
    ./btop.nix
    ./cava.nix
    ./checkshell.nix
    ./cliphist.nix
    ./mpdchck.nix
  ];
}
