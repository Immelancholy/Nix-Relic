{pkgs, ...}: let
  gs = pkgs.writeShellScriptBin "gs" ''
    set -xeuo pipefail

    gamescopeArgs=(
        --rt
        -e
        -r 144
        -f
    )
    steamArgs=(
        -pipewire-dmabuf
        -tenfoot
        -steamos3
        -gamepadui
    )
    mangoConfig=(
        cpu_temp
        gpu_temp
        ram
        vram
    )
    mangoVars=(
        MANGOHUD=1
        MANGOHUD_CONFIG="''$(IFS=,; echo "''${mangoConfig[*]}")"
    )
    export "''${mangoVars[@]}"
    exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"
  '';
in {
  environment.systemPackages = [
    gs
    (pkgs.writeTextDir "share/wayland-sessions/steam.desktop" ''
      [Desktop Entry]
      Name=Steam (gamescope)
      Comment=A digital distribution platform
      Exec=${gs}/bin/gs
      Type=Application
    '')
  ];
}
