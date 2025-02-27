{pkgs, ...}: {
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.graphics = {
    enable = true;
    # package = pkgs.mesa.drivers;
    enable32Bit = true;
    # package32 = pkgs.pkgsi686Linux.mesa.drivers;
    extraPackages = with pkgs; [
      libvdpau-va-gl
      libvdpau
      vaapiVdpau
      amdvlk
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      libvdpau-va-gl
      libva-vdpau-driver
      amdvlk
    ];
  };
}
