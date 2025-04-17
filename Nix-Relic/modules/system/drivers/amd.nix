{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.amd;
in {
  options.drivers.amd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Enable AMD Graphics Drivers'';
    };
  };
  config = mkIf cfg.enable {
    services.xserver.videoDrivers = ["amdgpu"];

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
      ];
    };
  };
}
