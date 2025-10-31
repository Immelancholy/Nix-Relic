{
  nixosConfig,
  lib,
}:
with lib; let
  cfg = nixosConfig.nix-relic;
in {
  imports = mkIf cfg.enable [
    ./home
  ];
}
