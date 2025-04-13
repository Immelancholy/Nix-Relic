{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.nvidia.prime;
  busIDType = lib.types.strMatching "([[:print:]]+[:@][0-9]{1,3}:[0-9]{1,2}:[0-9])?";
in {
  options.drivers.nvidia.prime = {
    enable = mkEnableOption "Enable Nvidia Prime Offload";
    nvidiaBusId = mkOption {
      type = busIDType;
      default = "";
      example = "PCI:1:0:0";
    };
    amdgpuBusId = mkOption {
      type = busIDType;
      default = "";
      example = "PCI:54:0:0";
    };
    intelBusId = mkOption {
      type = busIDType;
      default = "";
      example = "PCI:0:2:0";
    };
  };
  config = mkIf cfg.enable {
    hardware.nvidia = {
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "${cfg.intelBusId}";
        nvidiaBusId = "${cfg.nvidiaBusId}";
        amdgpuBusId = "${cfg.amdgpuBusId}";
      };
    };
  };
}
