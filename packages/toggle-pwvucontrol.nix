{
  writeShellApplication,
  procps,
  kitty,
  pwvucontrol,
  uwsm,
}:
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    procps
    kitty
    uwsm
    pwvucontrol
  ];
  text = /* Bash */ ''
    if pgrep -f ".*pwvucontrol" >/dev/null; then
            pkill -f ".*pwvucontrol"
    elif pgrep -f "kitty.*-top-bar|pwvucontrol" >/dev/null; then
            pkill -f "kitty.*-top-bar|pwvucontrol"
            uwsm-app -- pwvucontrol "$@"
    else
            uwsm-app -- pwvucontrol "$@"
    fi
  '';
}
