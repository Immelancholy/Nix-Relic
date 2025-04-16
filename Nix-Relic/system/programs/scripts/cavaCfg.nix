{
  lib,
  pkgs,
  ...
}: let
  cavaCfg = pkgs.writeShellScriptBin "cavaCfg" ''
    cavaConfigFile=$HOME/.config/cava/vcConfig
    id=$(${pkgs.wireplumber}/bin/wpctl status | grep "virtual_cable_in" | ${pkgs.gawk}/bin/awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
    serial=$(${pkgs.wireplumber}/bin/wpctl inspect "''${id}" | sed -n 's/.*object.serial = //p')

    cat >"$cavaConfigFile" <<EOF
    [color]
    gradient=1
    gradient_color_1='#94e2d5'
    gradient_color_2='#89dceb'
    gradient_color_3='#74c7ec'
    gradient_color_4='#89b4fa'
    gradient_color_5='#cba6f7'
    gradient_color_6='#f5c2e7'
    gradient_color_7='#eba0ac'
    gradient_color_8='#f38ba8'

    [general]
    bar_spacing=0
    bar_width=1
    bars=0
    framerate=144
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
    noise_reduction=72
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
  };
}
