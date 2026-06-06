{ writeShellScriptBin, ... }:
writeShellScriptBin "rofi-cliphist" (builtins.readFile ./Bash/cliphist.sh)
