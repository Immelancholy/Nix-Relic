{
  writeShellApplication,
  procps,
  kitty,
  self,
  pkgs,
  uwsm,
  lib,
  playerTitle ? "zarumet",
  playerCmd ? "zarumet",
  playerClass ? "mpd",
  playerPkg ? self.inputs.zarumet.packages.${pkgs.stdenv.hostPlatform.system}.default,
}:
let
  player-top-bar = writeShellApplication {
    name = "player-top-bar";
    runtimeInputs = [
      playerPkg
    ];
    text = ''
      ${playerCmd}
    '';
  };
in
writeShellApplication {
  name = "toggle-player";
  runtimeInputs = [
    procps
    kitty
    uwsm
    playerPkg
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*-top-bar" >/dev/null; then
            pkill -f "kitty.*-top-bar"
    else
            uwsm-app -- kitty --class "${playerClass}" --title "${playerTitle}-top-bar" -e ${lib.getExe player-top-bar} "$@"
    fi
  '';
}
