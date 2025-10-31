{writeShellApplication, ...}:
writeShellApplication {
  name = "checkshell.sh";
  text = ''
    shell=$($SHELL --version)
    shell=''${shell^}
    echo "$shell"
  '';
}
