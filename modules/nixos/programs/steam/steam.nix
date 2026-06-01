{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.programs.steam;
in
{
  config = lib.mkIf cfg.enable {
    programs.steam = {
      package = pkgs.steam.override {
        extraEnv = {
          OBS_VKCAPTURE = true;
          MANGOHUD = true;
          DXVK_HUD = "compiler";
          LD_PRELOAD = "${pkgs.gamemode.lib}/lib/libgamemode.so";
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraPackages = [
        pkgs.libxcb
        pkgs.libXcursor
        pkgs.libXi
        pkgs.libXinerama
        pkgs.libXScrnSaver
        pkgs.libpng
        pkgs.libpulseaudio
        pkgs.libvorbis
        pkgs.stdenv.cc.cc.lib
        pkgs.libkrb5
        pkgs.keyutils
      ];
      protontricks.enable = true;
    };
    environment.systemPackages = with pkgs; [
      protonup-ng
      protonplus
    ];
  };
}
