{
  writeShellApplication,
  procps,
  kitty,
  self,
  pkgs,
}:
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    procps
    kitty
    self.inputs.linktui.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*linktui" >/dev/null; then
            pkill -f "kitty.*linktui"
    else
            kitty --title "linktui" -e linktui "$@"
    fi
  '';
}
