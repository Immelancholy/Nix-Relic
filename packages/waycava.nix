{
  writeShellApplication,
  pkgs,
  cavaDevice ? "virtual_cable_in",
  ...
}: let
  waycava = builtins.readFile ./Bash/waycava.sh;
in
  writeShellApplication {
    name = "waycava.sh";

    runtimeInputs = [
      pkgs.wireplumber
      pkgs.gawk
      pkgs.cava
    ];

    text = ''
      CAVA_DEVICE=${cavaDevice}
      set +o errexit
      set +o nounset
      set +o pipefail
      ${waycava}
    '';
  }
