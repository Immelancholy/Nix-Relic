{
  writeShellApplication,
  procps,
  kitty,
  self,
  uwsm,
  pkgs,
  lib,
}:
let
  linktui-top-bar = writeShellApplication {
    name = "player-top-bar";
    runtimeInputs = [
      self.inputs.linktui.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    text = ''
      linktui "$@"
    '';
  };
in
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    procps
    kitty
    uwsm
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*-top-bar" >/dev/null; then
            pkill -f "kitty.*-top-bar"
    else
            uwsm-app -- kitty --class "linktui" --title "linktui-top-bar" -e ${lib.getExe linktui-top-bar} "$@"
    fi
  '';
}
