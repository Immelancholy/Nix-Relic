{writeShellApplication, ...}:
writeShellApplication { 
  name = "flake-cli"; 
  text = builtins.readFile ./Bash/flake-cli;
}
