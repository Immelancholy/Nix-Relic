{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.nvtopPackages.full # nvtop
    pkgs.mesa-demos
    pkgs.vulkan-tools
    pkgs.libva-utils
    pkgs.vdpauinfo
    pkgs.driversi686Linux.vdpauinfo
  ];

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
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      libvdpau-va-gl
      libva-vdpau-driver
    ];
  };
  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      support32Bit = true;
    };
    initrd.enable = true;
  };
}
