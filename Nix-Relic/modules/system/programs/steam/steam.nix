{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.programs.steam;
in {
  config = lib.mkIf cfg.enable {
    programs.steam = {
      package = pkgs.steam.override {
        extraEnv = {
          OBS_VKCAPTURE = true;
          MANGOHUD = true;
          DXVK_HUD = "compiler";
        };
      };
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraPackages = [
        pkgs.xorg.libxcb
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
      ];
      protontricks.enable = true;
    };
  };
}
