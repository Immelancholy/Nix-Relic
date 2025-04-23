{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.boot.secureBoot;
in {
  options.boot.secureBoot = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''Enable Secure Boot'';
    };
  };
  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
