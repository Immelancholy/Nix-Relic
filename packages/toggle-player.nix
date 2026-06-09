{
  writeShellApplication,
  procps,
  kitty,
  self,
  pkgs,
  playerTitle ? "zarumet",
  playerCmd ? "zarumet",
  playerPkg ? self.inputs.zarumet.packages.${pkgs.stdenv.hostPlatform.system}.default,
}:
writeShellApplication {
  name = "toggle-zarumet";
  runtimeInputs = [
    procps
    kitty
    playerPkg
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*${playerCmd}" >/dev/null; then
            pkill -f "kitty.*${playerCmd}"
    else
            kitty --title "${playerTitle}" -e ${playerCmd} "$@"
    fi
  '';
}
