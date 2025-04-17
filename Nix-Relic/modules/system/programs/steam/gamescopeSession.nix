{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.programs.steam.gamescopeSession;
  steam-gamescope = pkgs.writeShellScriptBin "steam-gamescope" ''
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
      Exec=${steam-gamescope}/bin/steam-gamescope
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
  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.mkIf cfg.enable [
      steam-gamescope
      steamscope
      steamos-session-select
    ];
    programs.steam = {
      extraPackages = lib.mkIf cfg.enable [
        steamos-session-select
        steamos-select-branch
        steamos-update
        jupiter-biosupdate
      ];
    };
    services.displayManager.sessionPackages = [steamscope];
  };
}
