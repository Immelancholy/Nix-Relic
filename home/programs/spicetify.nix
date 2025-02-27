{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extension; [
      adblockify
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;

    colorScheme = "mocha";
  };
}
