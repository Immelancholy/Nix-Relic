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
  security.polkit = {
    enable = true;
  };
  # boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "rw"
    "quiet"
    "splash"
    "discard"
  ];
}
