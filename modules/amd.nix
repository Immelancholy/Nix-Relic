{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.nvtopPackages.full # nvtop
    pkgs.mesa-demos
    pkgs.vulkan-tools
    pkgs.libva-utils
    pkgs.vdpauinfo
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
