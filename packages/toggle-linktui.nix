{
  writeShellApplication,
  procps,
  kitty,
}:
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    procps
    kitty
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*linktui" >/dev/null; then
            pkill -f "kitty.*linktui"
    else
            kitty --title "linktui" -e linktui "$1"
    fi
  '';
}
