{writeShellScriptBin, ...}:
writeShellScriptBin "rofi-power-menu" (builtins.readFile ./Bash/rofi-power-menu)
