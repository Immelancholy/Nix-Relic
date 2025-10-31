{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.nix-relic;
in {
  options.nix-relic.enable = mkEnableOption "Enable Nix-Relic";

  imports = mkIf cfg.enable [
    ./system
  ];
}
