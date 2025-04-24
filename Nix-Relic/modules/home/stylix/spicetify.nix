{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib; let
  cfg = config.stylix.targets.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  config = mkIf (!cfg.enable) {
    programs.spicetify = {
      theme = spicePkgs.themes.catppuccin;

      colorScheme = config.catppuccin.flavor;
    };
  };
}
