{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware.nvidia;
in
{
  options.hardware.nvidia.enable = mkEnableOption "Enable Nvidia drivers";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nvtopPackages.full # nvtop
      pkgs.mesa-demos
      pkgs.vulkan-tools
      pkgs.vdpauinfo
      pkgs.vulkan-validation-layers
    ];

    boot.blacklistedKernelModules = [
      "nouveau"
      "nova_core"
    ];

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      LIBVA_DRIVER_NAME = "nvidia";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva-vdpau-driver
        libva-utils
        libva
        egl-wayland
        vulkan-hdr-layer-kwin6
      ];
    };

    nix.settings.substituters = lib.mkAfter [ "https://cache.nixos-cuda.org" ];
    nix.settings.trusted-public-keys = lib.mkAfter [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
}
