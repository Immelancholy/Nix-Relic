{writeShellScriptBin, ...}:
writeShellScriptBin "relic-cli" (builtins.readFile ./Bash/relic-cli)
