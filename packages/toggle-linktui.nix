{
  writeShellApplication,
  procps,
  kitty,
  self,
  uwsm,
  pkgs,
  tab ? "",
}:
let
  title = "linktui-${tab}-top-bar";
  linktui-top-bar = writeShellApplication {
    name = "${title}";
    runtimeInputs = [
      self.inputs.linktui.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    text = ''
      linktui -tab=${tab} "$@"
    '';
  };
in
writeShellApplication {
  name = "toggle-linktui";
  runtimeInputs = [
    procps
    kitty
    uwsm
    linktui-top-bar
  ];
  text = /* Bash */ ''
    if pgrep -f "kitty.*${title}" >/dev/null; then
            pkill -f "kitty.*${title}"
    elif pgrep -f "kitty.*-top-bar | pwvucontrol" >/dev/null; then
            pkill -f "kitty.*-top-bar | pwvucontrol"
            uwsm-app -- kitty --class "linktui" --title "${title}" -e ${title} "$@"
    else
            uwsm-app -- kitty --class "linktui" --title "${title}" -e ${title} "$@"
    fi
  '';
}
