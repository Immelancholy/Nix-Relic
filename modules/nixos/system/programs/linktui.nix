{ pkgs, nix-relic, ... }:
{
  imports = [
    nix-relic.inputs.linktui.nixosModules.default
  ];
  programs.linktui = {
    enable = true;
    package = pkgs.linktui;
  };
}
