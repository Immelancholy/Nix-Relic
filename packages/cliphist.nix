{writeShellScriptBin, ...}:
writeShellScriptBin "cliphist.sh" (builtins.readFile ./Bash/cliphist.sh)
