{
  pkgs,
  config,
  ...
}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd = {
    enable = true;
    tpm2.enable = true;
  };
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    bbswitch
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  boot.kernelParams = [
    "rw"
    "quiet"
    "splash"
    "discard"
    "fs.inotify.max_user_watches=524288"
  ];
  boot.lanzaboote = {
    settings = {
      editor = false;
    };
  };
}
