{
  pkgs,
  inputs,
  ...
}: let
  spicetify-nix = inputs.nix-relic.inputs.spicetify-nix.homeManagerModules.default;

  spicePkgs = inputs.nix-relic.inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    spicetify-nix
  ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      ncsVisualizer
      lyricsPlus
      newReleases
    ];
    windowManagerPatch = true;
  };
}
