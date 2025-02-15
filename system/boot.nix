{ pkgs, config, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ bbswitch ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "rw"
    "quiet"
    "splash"
    "usbcore.blinkenlights=1"
  ];
}
