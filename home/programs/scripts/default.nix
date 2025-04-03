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
    ./neo.nix
    ./nv.nix
    ./rmpc.nix
    ./swww.nix
    ./tmux_dev.nix
    ./tmux_nix.nix
    ./tmux_notes.nix
  ];
}
