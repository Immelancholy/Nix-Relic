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
        -steamdeck
        -gamepadui
    )
    # mangoConfig=(
    #     cpu_temp
    #     gpu_temp
    #     ram
    #     vram
    # )
    # mangoVars=(
    #     MANGOHUD=1
    #     MANGOHUD_CONFIG="''$(IFS=,; echo "''${mangoConfig[*]}")"
    # )
    # export "''${mangoVars[@]}"
    exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"
  '';
  steamos-session-select = pkgs.writeShellScriptBin "steamos-session-select" ''
    steam -shutdown
  '';
  steamscope = pkgs.writeTextDir "share/wayland-sessions/steam.desktop" ''
    [Desktop Entry]
    Name=Steam (gamescope)
    Comment=A digital distribution platform
    Exec=${gs}/bin/gs
    Type=Application
  '';
in {
  environment.systemPackages = [
    gs
    steamscope
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = true;
    };
    extraPackages = [
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.xorg.libXinerama
      pkgs.xorg.libXScrnSaver
      pkgs.libpng
      pkgs.libpulseaudio
      pkgs.libvorbis
      pkgs.stdenv.cc.cc.lib
      pkgs.libkrb5
      pkgs.keyutils
      steamos-session-select
    ];
    protontricks.enable = true;
  };
}
