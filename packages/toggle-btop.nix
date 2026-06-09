{
  writeShellApplication,
  procps,
  kitty,
  btop,
  uwsm,
  lib,
}:
let
  btop-top-bar = writeShellApplication {
    name = "btop-top-bar";
    runtimeInputs = [
      btop
    ];
    text = ''
      btop "$@"
    '';
  };
in
writeShellApplication {
  name = "toggle-btop";
  runtimeInputs = [
    procps
    kitty
    uwsm
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*btop-top-bar" >/dev/null; then
            pkill -f "kitty.*btop-top-bar"
    else
            uwsm-app -- kitty --class "btop" --title "btop-top-bar" -e ${lib.getExe btop-top-bar} "$@"
    fi
  '';
}
