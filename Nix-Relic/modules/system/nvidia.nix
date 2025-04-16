{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia;
in {
  options.drivers.nvidia = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Enable Nvidia Graphics Drivers'';
    };
    powerManagement = mkEnableOption "Enable power management";
    finePowerManagement = mkEnableOption "Enable fine-graned poer management for Prime Offload";
    open = mkOption {
      type = types.bool;
      default = false;
      description = "Use open source drivers";
    };
    package = mkOption {
      type = types.package;
      default = config.boot.kernelPackages.nvidiaPackages.latest;
      description = "Package for nvidia drivers to use";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.nvtopPackages.full # nvtop
      pkgs.mesa-demos
      pkgs.vulkan-tools
      pkgs.vdpauinfo
      pkgs.vulkan-validation-layers
    ];
    boot.blacklistedKernelModules = ["nouveau"];

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
      LIBVA_DRIVER_NAME = "nvidia";
      __GL_VRR_ALLOWED = "0";
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
        libva-vdpau-driver
        libva-utils
        libva
        egl-wayland
      ];
    };

    hardware.nvidia = {
      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      powerManagement = mkIf cfg.powerManagement {
        enable = true;
        finegrained = cfg.finePowerManagement;
      };

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      # Currently alpha-quality/buggy, so false is currently the recommended setting.
      open = cfg.open;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.

      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
      package = cfg.package;
    };
  };
}
