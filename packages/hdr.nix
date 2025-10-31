{writeShellScriptBin}:
writeShellScriptBin "force-hdr" ''
  FORCE_HDR=$(hyprctl getoption render:cm_fs_passthrough | sed -n '1p' | awk '{print $2}')
  MONITOR="$*"
  MONITOR_HDR="''${MONITOR%,*}"

  if [ "$FORCE_HDR" != 1 ]; then
  	hyprctl keyword monitor "$MONITOR_HDR, 10, cm, hdr"
  	hyprctl keyword render:cm_fs_passthrough 1
  else
  	hyprctl keyword monitor "$MONITOR, cm, srgb"
  	hyprctl keyword render:cm_fs_passthrough 2
  fi
''
