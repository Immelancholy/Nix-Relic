{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
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
    theme = spicePkgs.themes.catppuccin;

    colorScheme = "mocha";
    windowManagerPatch = true;
  };
}
