{
  pkgs,
  config,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd = {
    enable = true;
    tpm2.enable = true;
  };
  boot.extraModulePackages = with config.boot.kernelPackages; [
    bbswitch
  ];
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelParams = [
    "rw"
    "quiet"
    "splash"
    "discard"
  ];
}
