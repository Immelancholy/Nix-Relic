{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.hardware.intelgpu;
in
{
  options.hardware.intelgpu = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    };

    services.xserver.videoDrivers = [ "modesetting" ];

    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      VDPAU_DRIVER = "va_gl"; # Only if using libvdpau-va-gl
    };

    # OpenGL
    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt

        intel-compute-runtime

        libvdpau-va-gl
        libva
        libva-utils
      ];
    };

    hardware.enableRedistributableFirmware = true;
    boot.kernelParams = [ "i915.enable_guc=3" ];
  };
}
