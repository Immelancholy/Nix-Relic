{writeShellApplication, ...}:
writeShellApplication { 
  name = "relic-cli"; 
  text = builtins.readFile ./Bash/relic-cli;
}
