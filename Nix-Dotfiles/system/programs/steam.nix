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
        # -tenfoot
        # -steamdeck
        -steamos3
        -pipewire-dmabuf
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
    export tty=$(tty)
    export ENABLE_GAMESCCOPE_WSI=0
    export "''${mangoVars[@]}"
    exec gamescope "''${gamescopeArgs[@]}" -- steam "''${steamArgs[@]}"
  '';
  steamos-session-select = pkgs.writeShellScriptBin "steamos-session-select" ''
    steam -shutdown
    # if [ "$tty" = "/dev/tty1" ]; then
    #   chvt 2
    # elif [ "$(pgrep -x sddm)" != "" ]; then
    #   :
    # else
    #   chvt 1
    # fi
  '';
  steamos-select-branch = pkgs.writeShellScriptBin "steamos-select-branch" ''
    echo "Not applicable for this OS"
  '';
  steamscope =
    (pkgs.writeTextDir "share/wayland-sessions/steam.desktop" ''
      [Desktop Entry]
      Encoding=UTF-8
      Name=Steam (gamescope)
      Comment=Launch Steam within Gamescope
      Exec=${gs}/bin/gs
      Type=Application
      DesktopNames=gamescope
    '')
    .overrideAttrs (_: {passthru.providedSessions = ["steam"];});
  steamos-update = pkgs.writeShellScriptBin "steamos-update" ''
    exit 7;
  '';
  jupiter-biosupdate = pkgs.writeShellScriptBin "jupiter-biosupdate" ''
    exit 0;
  '';
in {
  environment.systemPackages = [
    gs
    steamscope
    steamos-session-select
  ];
  services.displayManager.sessionPackages = [steamscope];
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        OBS_VKCAPTURE = true;
        MANGOHUD = true;
        DXVK_HUD = "compiler";
      };
      extraLibraries = pkgs: [pkgs.xorg.libxcb];
    };
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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
      steamos-select-branch
      steamos-update
      jupiter-biosupdate
    ];
    protontricks.enable = true;
  };
}
