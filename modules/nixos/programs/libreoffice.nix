{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.libreoffice;
in {
  options.programs.libreoffice = {
    enable = mkEnablOption "Enable Libreoffice";
  };

  config = mkIf cfg.enable {
    environment.systemPackage = with pkgs; [
      libreoffice
    ];
  };
}
