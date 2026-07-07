{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.hardware.amdgpu;
in
{
  options.hardware.amdgpu.enable = mkEnableOption "Enable amdgpu packages";

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.systemPackages = [
      pkgs.nvtopPackages.full # nvtop
      pkgs.mesa-demos
      pkgs.vulkan-tools
      pkgs.vdpauinfo
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        vulkan-hdr-layer-kwin6
      ];
    };
  };
}
