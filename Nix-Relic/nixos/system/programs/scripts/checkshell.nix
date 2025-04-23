{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "checkshell.sh" ''
      shell=$($SHELL --version | cut -d ' ' -f 1)
      shell=''${shell^}
      echo "$shell"
    '')
  ];
}
