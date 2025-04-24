{
  pkgs,
  config,
  ...
}: let
  base = "${config.lib.stylix.colors.base00}";
  mantle = "${config.lib.stylix.colors.base01}";
  surface0 = "${config.lib.stylix.colors.base02}";
  surface1 = "${config.lib.stylix.colors.base03}";
  surface2 = "${config.lib.stylix.colors.base04}";
  text = "${config.lib.stylix.colors.base05}";
  rosewater = "${config.lib.stylix.colors.base06}";
  lavender = "${config.lib.stylix.colors.base07}";
  red = "${config.lib.stylix.colors.base08}";
  peach = "${config.lib.stylix.colors.base09}";
  yellow = "${config.lib.stylix.colors.base0A}";
  green = "${config.lib.stylix.colors.base0B}";
  teal = "${config.lib.stylix.colors.base0C}";
  blue = "${config.lib.stylix.colors.base0D}";
  mauve = "${config.lib.stylix.colors.base0E}";
  flamingo = "${config.lib.stylix.colors.base0F}";

  neo-color = pkgs.writeShellScriptBin "neo-color" ''
    neoDir="$XDG_CONFIG_HOME/neo"
    neoColorFile="$neoDir/colors"

    teal=$(colortrans ${teal} | sed -n '2p' | awk '{print $8}')
    blue=$(colortrans ${blue} | sed -n '2p' | awk '{print $8}')
    lavender=$(colortrans ${lavender} | sed -n '2p' | awk '{print $8}')
    mauve=$(colortrans ${mauve} | sed -n '2p' | awk '{print $8}')
    flamingo=$(colortrans ${flamingo} | sed -n '2p' | awk '{print $8}')
    peach=$(colortrans ${peach} | sed -n '2p' | awk '{print $8}')
    red=$(colortrans ${red} | sed -n '2p' | awk '{print $8}')
    text=$(colortrans ${text} | sed -n '2p' | awk '{print $8}')
    yellow=$(colortrans ${yellow} | sed -n '2p' | awk '{print $8}')

    if [ ! -d "$neoDir" ]; then
      echo "Making Neo Directory"
      mkdir -p "$neoDir"
    fi

    cat >"$neoColorFile" <<EOF
      neo_color_version 1
      -1
      ''${flamingo:11}
      ''${blue:11}
      ''${mauve:11}
      ''${teal:11}
      ''${text:11}
    EOF
  '';
in {
  environment.systemPackages = [
    neo-color
  ];
  systemd.user.services."neo-color" = {
    enable = true;
    name = "Neo Color";
    wantedBy = ["default.target"];
    path = [
      "/run/current-system/sw"
    ];
    script = ''neo-color'';
  };
}
