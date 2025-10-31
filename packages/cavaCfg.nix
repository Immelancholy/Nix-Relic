{
  writeShellScriptBin,
  pkgs,
  color1 ? "",
  color2 ? "",
  color3 ? "",
  color4 ? "",
  color5 ? "",
  color6 ? "",
  color7 ? "",
  framerate ? "",
  cavaDir ? "$HOME/.config/cava",
  ...
}:
writeShellScriptBin "cavaCfg" ''
  cavaDir="${cavaDir}"
  cavaConfigFile="$cavaDir/config"
  id=$(${pkgs.wireplumber}/bin/wpctl status | grep "virtual_cable_in" | ${pkgs.gawk}/bin/awk '{print $2}' | grep -m1 "" | cut -f1 -d ".")
  serial=$(${pkgs.wireplumber}/bin/wpctl inspect "''${id}" | sed -n 's/.*object.serial = //p')
  if $(( ${framerate} > 144 )); then
    framerate=144
  else
    framerate=${framerate}
  fi
  reduce=$((framerate / 2))

  if [ ! -d "$cavaDir" ]; then
    echo "Making cava Directory"
    mkdir -p "$cavaDir"
  fi

  cat >"$cavaConfigFile" <<EOF
  [color]
  gradient=1
  gradient_color_1='${color1}'
  gradient_color_2='${color2}'
  gradient_color_3='${color3}'
  gradient_color_4='${color4}'
  gradient_color_5='${color5}'
  gradient_color_6='${color6}'
  gradient_color_7='${color7}'

  [general]
  bar_spacing=0
  bar_width=1
  bars=0
  framerate=''${framerate}
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
''
