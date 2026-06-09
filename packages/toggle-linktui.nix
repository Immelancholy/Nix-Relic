{
  writeShellApplication,
  linktui,
  procps,
}:
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    linktui
    procps
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*linktui" >/dev/null; then
            pkill -f "kitty.*linktui"
    else
            kitty --title "linktui" -e linktui "$1"
    fi
  '';
}
