{
  lib,
  pkgs,
  config,
  ...
}: let
  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";
  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";
  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  mauve = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";

  cavaCfg = pkgs.writeShellScriptBin "cavaCfg" ''
    cavaConfigFile=$HOME/.config/cava/vcConfig
    id=$(${pkgs.wireplumber}/bin/wpctl status | grep "virtual_cable_in" | ${pkgs.gawk}/bin/awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
    serial=$(${pkgs.wireplumber}/bin/wpctl inspect "''${id}" | sed -n 's/.*object.serial = //p')
    reduce=$((FRAMERATE / 2))
    if (( $reduce > 90 )); then
      reduce=90
    fi

    cat >"$cavaConfigFile" <<EOF
    [color]
    gradient=1
    gradient_color_1='${teal}'
    gradient_color_2='${blue}'
    gradient_color_3='${lavender}'
    gradient_color_4='${mauve}'
    gradient_color_5='${flamingo}'
    gradient_color_6='${peach}'
    gradient_color_7='${red}'

    [general]
    bar_spacing=0
    bar_width=1
    bars=0
    framerate=''${FRAMERATE}
    sensitivity=100

    [input]
    method=pipewire
    source=''${serial}

    [output]
    channels=stereo
    method=noncurses
    mono_option=average

    [smoothing]
    monstercat=1
    noise_reduction=''${reduce}
    waves=0
    EOF
  '';
in {
  systemd.user.services."cavaCfg" = {
    enable = true;
    name = "cavaCfg";
    after = ["pipewire.service"];
    wantedBy = ["default.target"];
    path = [
      "${cavaCfg}"
    ];
    script = ''cavaCfg'';
    environment = {
      FRAMERATE = config.environment.sessionVariables.FRAMERATE;
    };
  };
}
