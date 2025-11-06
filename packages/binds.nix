{writeShellScriptBin, ...}:
writeShellScriptBin "binds.sh" (builtins.readFile ./Bash/binds.sh)
