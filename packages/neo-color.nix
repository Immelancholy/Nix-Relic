{
  writeShellApplication,
  pkgs,
  color1 ? "",
  color2 ? "",
  color3 ? "",
  color4 ? "",
  color5 ? "",
  ...
}: let
  colortrans = pkgs.callPackage ./colortrans.nix {};
in
  writeShellApplication {
    name = "neo-color";

    runtimeInputs = [
      colortrans
      pkgs.gawk
    ];
    text = ''
      neoDir="$XDG_CONFIG_HOME/neo"
      neoColorFile="$neoDir/colors"

      color1=$(colortrans ${color1} | sed -n '2p' | awk '{print $8}')
      color2=$(colortrans ${color2} | sed -n '2p' | awk '{print $8}')
      color3=$(colortrans ${color3} | sed -n '2p' | awk '{print $8}')
      color4=$(colortrans ${color4} | sed -n '2p' | awk '{print $8}')
      color5=$(colortrans ${color5} | sed -n '2p' | awk '{print $8}')

      if [ ! -d "$neoDir" ]; then
        echo "Making Neo Directory"
        mkdir -p "$neoDir"
      fi

      cat >"$neoColorFile" <<EOF
        neo_color_version 1
        -1
        ''${color1:11}
        ''${color2:11}
        ''${color3:11}
        ''${color4:11}
        ''${color5:11}
      EOF
    '';
  }
