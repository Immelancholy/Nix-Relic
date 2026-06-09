{
  writeShellApplication,
  procps,
  kitty,
  self,
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
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*linktui-top-bar" >/dev/null; then
            pkill -f "kitty.*linktui-top-bar"
    else
            kitty --class "linktui" --title "linktui-top-bar" -e ${lib.getExe linktui-top-bar} "$@"
    fi
  '';
}
